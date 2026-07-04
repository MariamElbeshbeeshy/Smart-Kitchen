import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';
import 'package:smart_kitchen/services/marketplace_service.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _marketController = TextEditingController();
  final _unitController = TextEditingController();
  final _imageNameController = TextEditingController();

  String _selectedCategory = "Fruits";
  bool _isLoading = false;

  final List<String> _categories = [
    "Fruits",
    "Vegetables",
    "Dairy",
    "Drinks",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _marketController.dispose();
    _unitController.dispose();
    _imageNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final product = MarketplaceProduct(
        id: '',
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        category: _selectedCategory,
        rating: 0.0,
        reviews: 0,
        market: _marketController.text.trim(),
        description: _descriptionController.text.trim(),
        stock: 0,
        unit: _unitController.text.trim(),
        imageName: _imageNameController.text.trim(),
      );

      await MarketplaceService().addProduct(product);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product added successfully!"),
            backgroundColor: kPrimaryColor,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
  appBar: AppBar(
  backgroundColor: const Color(0xffF8F8F8), // ← نفس لون الـ body
  elevation: 0,
  leading: GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
    ),
  ),
  title: const Text(
    "Add Product",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Color(0xff1A1A1A),
    ),
  ),
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Product Name
              _buildLabel("Product Name"),
              _buildTextField(
                controller: _nameController,
                hint: "e.g. Fresh Mango",
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 16),

              // Price
              _buildLabel("Price (\$)"),
              _buildTextField(
                controller: _priceController,
                hint: "e.g. 2.99",
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v!.isEmpty) return "Required";
                  if (double.tryParse(v) == null) return "Enter a valid number";
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Category
              _buildLabel("Category"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    items: _categories.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedCategory = val!),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Market
              _buildLabel("Market"),
              _buildTextField(
                controller: _marketController,
                hint: "e.g. Fresh Market",
              ),

              const SizedBox(height: 16),

              // Unit
              _buildLabel("Unit"),
              _buildTextField(
                controller: _unitController,
                hint: "e.g. Kg, Box, Piece",
              ),

              const SizedBox(height: 16),

              // Image Name
              _buildLabel("Image Name"),
              _buildTextField(
                controller: _imageNameController,
                hint: "e.g. mango.png",
              ),

              const SizedBox(height: 16),

              // Description
              _buildLabel("Description"),
              _buildTextField(
                controller: _descriptionController,
                hint: "Write a short description...",
                maxLines: 4,
              ),

              const SizedBox(height: 32),

              // Submit Button
              GestureDetector(
                onTap: _isLoading ? null : _submit,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Add Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}