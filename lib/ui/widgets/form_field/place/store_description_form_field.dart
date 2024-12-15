import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class StoreDescriptionFormField extends StatefulWidget {
  final TextEditingController controller; // 컨트롤러
  final ValueChanged<String>? onChanged; // 텍스트 변경 이벤트

  const StoreDescriptionFormField({
    Key? key,
    required this.controller,
    this.onChanged, // onChanged 전달
  }) : super(key: key);

  @override
  _StoreDescriptionFormFieldState createState() =>
      _StoreDescriptionFormFieldState();
}

class _StoreDescriptionFormFieldState extends State<StoreDescriptionFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 전달된 컨트롤러를 사용
    _controller = widget.controller;

    // 컨트롤러에 리스너 추가
    _controller.addListener(() {
      widget.onChanged?.call(_controller.text); // 텍스트 변경 시 onChanged 호출
    });
  }

  @override
  void dispose() {
    // 리스너 제거
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      minLines: 8, // 최소 8줄로 설정
      maxLines: null, // 줄 수 제한 없음
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: '우리 매장의 매력 포인트를 어필해주세요~',
        border: OutlineInputBorder(),
      ),
      validator: ValidatorUtil.validatorStoreDiscription,
      scrollPhysics: const BouncingScrollPhysics(), // 스크롤 가능하도록 설정
    );
  }
}
