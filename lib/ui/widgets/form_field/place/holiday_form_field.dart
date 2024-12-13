import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class HolidayFormField extends StatelessWidget {
  HolidayFormField({
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: 'ex) 연중무휴/ 매주 월요일 휴무'),
      validator: ValidatorUtil.validatorHoliday,
    );
  }
}
