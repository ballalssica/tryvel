import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // TextInputFormatter를 위한 패키지
import 'package:tryvel/core/utils/validator_util.dart';

class StoreNumberFormField extends StatefulWidget {
  final TextEditingController controller; // 컨트롤러
  final ValueChanged<String>? onChanged; // onChanged 매개변수

  const StoreNumberFormField({
    Key? key,
    required this.controller,
    this.onChanged,
    required String? Function(String? value) validator, // onChanged 전달
  }) : super(key: key);

  @override
  _StoreNumberFormFieldState createState() => _StoreNumberFormFieldState();
}

class _StoreNumberFormFieldState extends State<StoreNumberFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 전달된 컨트롤러를 초기화
    _controller = widget.controller;

    // 리스너 추가
    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
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
