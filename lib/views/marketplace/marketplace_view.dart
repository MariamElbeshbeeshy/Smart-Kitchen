import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/marketplace_cubit/marketplace_cubit.dart';
import 'package:smart_kitchen/cubits/marketplace_cubit/marketplace_states.dart';
import 'package:smart_kitchen/widgets/marketplace/marketplace_header.dart';
import 'package:smart_kitchen/widgets/marketplace/marketplace_search_bar.dart';
import 'package:smart_kitchen/widgets/marketplace/marketplace_filters.dart';
import 'package:smart_kitchen/widgets/marketplace/marketplace_grid.dart';
import 'package:smart_kitchen/views/marketplace/product_details_view.dart';

class MarketplaceView extends StatefulWidget {
  const MarketplaceView({super.key});

  @override
  State<MarketplaceView> createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends State<MarketplaceView> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<MarketplaceCubit>().loadProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
                builder: (context, state) {
                  if (state is MarketplaceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MarketplaceError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is MarketplaceLoaded) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarketplaceHeader(
                            productCount: state.filteredProducts.length,
                          ),

                          const SizedBox(height: 25),

                          MarketplaceSearchBar(
                            controller: searchController,
                            onChanged: (value) {
                              context.read<MarketplaceCubit>().searchProducts(
                                value,
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          MarketplaceFilters(
                            categories: const [
                              "All",
                              "Fruits",
                              "Vegetables",
                              "Dairy",
                              "Drinks",
                            ],
                            selectedCategory: state.selectedCategory,
                            onCategorySelected: (category) {
                              context.read<MarketplaceCubit>().filterProducts(
                                category,
                              );
                            },
                          ),

                          const SizedBox(height: 20),

                          MarketplaceGrid(
                            products: state.filteredProducts,
                            onProductTap: (product) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailsView(product: product),
                                ),
                              );
                            },
                            onAddToCart: (product) {
                              Navigator.pushNamed(context, '/cart');
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
