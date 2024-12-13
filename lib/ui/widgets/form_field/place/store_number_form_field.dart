import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // TextInputFormatter를 위한 패키지
import 'package:tryvel/core/utils/validator_util.dart';

class StoreNumberFormField extends StatelessWidget {
  final TextEditingController controller;

  const StoreNumberFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone, // 전화번호 전용 키보드
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9-]+$')), // 숫자와 '-'만 허용
      ],
      decoration: const InputDecoration(
        hintText: 'ex) 02-123-4567',
        border: OutlineInputBorder(),
      ),
      validator: ValidatorUtil.validatorstoreNumber,
    );
  }
}
