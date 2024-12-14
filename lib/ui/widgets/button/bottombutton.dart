import 'package:flutter/material.dart';

// class Bottombutton extends StatelessWidget {
//   final VoidCallback? onPressed; // 버튼 클릭 시 실행할 동작
//   final String label; // 버튼 텍스트
//   final bool isEnabled; // 버튼 활성화 여부

//   const Bottombutton({
//     Key? key,
//     required this.onPressed,
//     required this.label,
//     this.isEnabled = false, // 기본값은 비활성화
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: isEnabled ? onPressed : null, // 활성화 상태에 따라 클릭 가능/불가능 설정
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size.fromHeight(60), // 버튼 높이
//         backgroundColor: isEnabled ? Colors.blue : Colors.grey, // 활성화/비활성화 색상
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

class Bottombutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const Bottombutton({
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
