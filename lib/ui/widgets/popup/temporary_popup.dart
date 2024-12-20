import 'package:flutter/material.dart';

class TemporaryPopup extends StatelessWidget {
  final String text; // 부모 위젯에서 전달받을 텍스트

  const TemporaryPopup({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
