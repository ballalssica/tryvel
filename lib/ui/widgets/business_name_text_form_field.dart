import 'package:flutter/material.dart';
import 'package:tryvel/core/validator_util.dart';

class BusinessNameTextFormField extends StatelessWidget {
  BusinessNameTextFormField({
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: '상호명과 같다면 입력하지 않아도 괜찮아요.'),
    );
  }
}
