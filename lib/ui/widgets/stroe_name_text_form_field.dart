import 'package:flutter/material.dart';
import 'package:tryvel/core/validator_util.dart';

class StroeNameTextFormField extends StatelessWidget {
  StroeNameTextFormField({
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: '매장명을 입력해 주세요'),
      validator: ValidatorUtil.validatorStoreName,
    );
  }
}
