import 'package:flutter/material.dart';
import 'package:tryvel/core/constants/categories.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class CategoryDropdownFormField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CategoryDropdownFormField({
    Key? key,
    required this.controller,
    this.onChanged,
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
    // 컨트롤러의 값으로 초기화
    dropdownValue =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  @override
  void didUpdateWidget(CategoryDropdownFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 컨트롤러 값이 업데이트되면 드롭다운 값 동기화
    if (widget.controller.text != dropdownValue) {
      setState(() {
        dropdownValue =
            widget.controller.text.isNotEmpty ? widget.controller.text : null;
      });
    }
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
      hint: const Text(
        '업종을 선택해주세요.',
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.grey,
      ),
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
          if (widget.onChanged != null && newValue != null) {
            widget.onChanged!(newValue);
          }
        });
      },
      validator: (value) => ValidatorUtil.validatorCategory(value),
    );
  }
}
