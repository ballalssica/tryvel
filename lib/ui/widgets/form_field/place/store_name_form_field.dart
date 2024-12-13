import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class StoreNameFormField extends StatelessWidget {
  StoreNameFormField({
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: '상호명을 입력해 주세요.'),
      validator: ValidatorUtil.validatorStoreName,
    );
  }
}
