import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({super.key, required this.items, this.onChange, this.hintText,  this.isDataTypeString});

  final List<String> items;
  final Function(dynamic)? onChange;
  final String? hintText;
  final bool? isDataTypeString;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(hintText??''),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: const InputDecoration(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
        onChanged: onChange);
  }
}
