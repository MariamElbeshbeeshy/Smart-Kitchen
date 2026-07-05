import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/pantry_cubit/pantry_cubit.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';
import 'package:smart_kitchen/widgets/pantry_sys/product_image.dart';
import 'package:smart_kitchen/widgets/pantry_sys/product_info.dart';
import 'package:smart_kitchen/widgets/quantity_counter.dart';

class PantryItemDetailsView extends StatefulWidget {
  final PantryItemModel product;
  const PantryItemDetailsView({super.key, required this.product});

  @override
  State<PantryItemDetailsView> createState() => _PantryItemDetailsViewState();
}

class _PantryItemDetailsViewState extends State<PantryItemDetailsView> {
  late int quantity;
  late Color color;
  late dynamic key;

  @override
  void initState() {
    quantity = widget.product.quantity;
    color = widget.product.statusColor;
    key = widget.product.key;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ProductImage(product: widget.product),
          SizedBox(height: 20),
          Flexible(
            flex: 52,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductInfo(product: widget.product, color: color),
                  const SizedBox(height: 30),
                  QuantityCounter(
                    value: quantity,
                    onChanged: (newValue) {
                      setState(() {
                        quantity = newValue;
                      });
                      context.read<PantryCubit>().updatePantryItem(
                            itemToUpdate: widget.product,
                            newQuantity: quantity,
                            itemKey: key,
                          );
                    },
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<PantryCubit>().deletePantryItem(key);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete from Pantry'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
