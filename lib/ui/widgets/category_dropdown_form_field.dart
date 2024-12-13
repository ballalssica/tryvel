import 'package:flutter/material.dart';
import 'package:tryvel/core/constants/categories.dart';

class CategoryDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const CategoryDropdownFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CategoryDropdownFormFieldState createState() =>
      _CategoryDropdownFormFieldState();
}

class _CategoryDropdownFormFieldState extends State<CategoryDropdownFormField> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : null; // 초기값 설정
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
      value: dropdownValue,
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
          widget.controller.text = newValue ?? '';
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '카테고리를 선택해주세요';
        }
        return null;
      },
    );
  }
}
