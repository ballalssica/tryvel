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
  @override
  void initState() {
    super.initState();

    // 컨트롤러 초기값 설정 (초기 데이터 표시)
    if (widget.controller.text.isNotEmpty) {
      setState(() {}); // 초기값이 있을 때 UI 업데이트
    }

    // 컨트롤러에 리스너 추가
    widget.controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.text); // 텍스트 변경 시 onChanged 호출
      }
    });
  }

  @override
  void dispose() {
    // 리스너 제거
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // 컨트롤러 전달
      decoration: InputDecoration(
        hintText: widget.controller.text.isEmpty
            ? 'ex) 주차가능/ 주차불가/ 주변 공용주차장 이용' // 값이 없으면 힌트 텍스트 표시
            : null, // 값이 있을 경우 힌트 텍스트 비활성화
      ),
      validator: ValidatorUtil.validatorparking,
    );
  }
}
