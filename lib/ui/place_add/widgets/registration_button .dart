import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const RegistrationButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60), // 버튼 높이 설정
      ),
      child: Text(label),
    );
  }
}
