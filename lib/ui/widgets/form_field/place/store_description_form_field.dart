import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class StoreDescriptionFormField extends StatelessWidget {
  StoreDescriptionFormField({
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 8, // 최소 5줄로 설정
      maxLines: null, // 줄 수 제한 없음
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: '우리매장의 매력포인트를 어필해주세요~',
      ),
      validator: ValidatorUtil.validatorStoreDiscription,
      scrollPhysics: BouncingScrollPhysics(), // 스크롤 가능하도록 설정
    );
  }
}
