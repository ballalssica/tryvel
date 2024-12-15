import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class ParkingFormField extends StatefulWidget {
  final TextEditingController controller; // 컨트롤러
  final ValueChanged<String>? onChanged; // 텍스트 변경 이벤트

  const ParkingFormField({
    Key? key,
    required this.controller,
    this.onChanged, // onChanged 매개변수 추가
  }) : super(key: key);

  @override
  _ParkingFormFieldState createState() => _ParkingFormFieldState();
}

class _ParkingFormFieldState extends State<ParkingFormField> {
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
      decoration: const InputDecoration(
        hintText: 'ex) 주차가능/ 주차불가/ 주변 공용주차장 이용',
      ),
      validator: ValidatorUtil.validatorparking,
    );
  }
}
