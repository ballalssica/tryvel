import 'package:flutter/material.dart';

class ContentButton extends StatelessWidget {
  final IconData icon; // 아이콘 데이터
  final String text; // 텍스트
  final VoidCallback onTap; // 버튼 클릭 동작

  const ContentButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            height: 70, // 버튼 높이
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFF5F5F5),
                  width: 1.0, // 경계선 두께
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 아이콘
                Icon(
                  icon,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 16), // 아이콘과 텍스트 간격
                // 텍스트
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                // 오른쪽 화살표 아이콘
                const Icon(
                  Icons.keyboard_arrow_right, // 꼬리 없는 화살표 아이콘
                  color: Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 8), // 오른쪽 간격
              ],
            ),
          ),
        ),
      ),
    );
  }
}
