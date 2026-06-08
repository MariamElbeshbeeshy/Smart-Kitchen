import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/pantry_cubit/pantry_cubit.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';
import 'package:smart_kitchen/widgets/category_dropdown.dart';
import 'package:smart_kitchen/widgets/custom_appbar.dart';
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
      final newItem = PantryItemModel(
        name: _nameController.text,
        category: _selectedCategory,
        expiryDate: _selectedDate,
        quantity: _quantity,
      );
      context.read<PantryCubit>().addPantryItem(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PantryAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Add to Pantry',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Log your ingredients to keep track of what you have and when it expires.',
                style: TextStyle(
                  color: const Color.fromARGB(255, 106, 106, 106),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
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
