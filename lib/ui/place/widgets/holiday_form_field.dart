import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class HolidayFormField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const HolidayFormField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _HolidayFormFieldState createState() => _HolidayFormFieldState();
}

class _HolidayFormFieldState extends State<HolidayFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 기존 컨트롤러를 받아와서 사용
    _controller = widget.controller;

    // 컨트롤러에 리스너 추가
    _controller.addListener(() {
      // 입력 중인 텍스트를 onChanged로 전달
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    // 리스너 제거 및 컨트롤러 정리
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text, // 기본 텍스트 입력 방식 설정
      decoration: const InputDecoration(
        hintText: 'ex) 연중무휴/ 매주 월요일 휴무',
      ),
      validator: ValidatorUtil.validatorHoliday,
    );
  }
}
