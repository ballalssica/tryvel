import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class ParkingFormField extends StatelessWidget {
  ParkingFormField({
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: 'ex) 주차가능/ 주차불가/ 주변 공용주차장 이용'),
      validator: ValidatorUtil.validatorparking,
    );
  }
}
