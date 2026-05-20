import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/widgets/category_dropdown.dart';
import 'package:smart_kitchen/widgets/custom_text_field.dart';
import 'package:smart_kitchen/widgets/expiry_date_picker.dart';
import 'package:smart_kitchen/widgets/quantity_counter.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({super.key});
  static String id = 'add item view';

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  int _quantity = 1;

  String _selectedCategory = 'DAIRY';
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add to Pantry',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              CustomTextField(
                label: 'Product Name',
                hint: 'e.g., Whole Milk',
                controller: _nameController,
                validator: (val) =>
                    val!.isEmpty ? 'Please enter product name' : null,
              ),
              const SizedBox(height: 20),

              CategoryDropdown(
                selectedValue: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              ExpiryDatePicker(
                selectedDate: _selectedDate,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              const SizedBox(height: 20),
              QuantityCounter(
                value: _quantity,
                onChanged: (newValue) {
                  setState(() {
                    _quantity = newValue; // تحديث القيمة محلياً عند الضغط
                  });
                },
              ),
              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Add to Pantry'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
