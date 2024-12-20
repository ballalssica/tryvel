import 'package:flutter/material.dart';

class TwoButtonPopup extends StatelessWidget {
  final Widget content; // 팝업의 텍스트 영역 (외부에서 제공)
  final VoidCallback onCancel; // 취소 버튼 동작
  final VoidCallback onConfirm; // 확인 버튼 동작

  const TwoButtonPopup({
    Key? key,
    required this.content,
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // 팝업 모서리 둥글게
      ),
      backgroundColor: Colors.white, // 배경색을 화이트로 설정
      child: Column(
        mainAxisSize: MainAxisSize.min, // 팝업의 크기를 내용에 맞게 설정
        children: [
          // 상단 텍스트 영역 (200픽셀 높이 설정)
          SizedBox(
            height: 200.0, // 고정된 높이 설정
            child: Center(
              // 중앙 정렬
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: content,
              ),
            ),
          ),

          // 버튼 영역
          Row(
            children: [
              // 취소 버튼
              Expanded(
                child: TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF4A4A4A),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16.0), // 버튼 높이를 증가
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),

              // 확인 버튼
              Expanded(
                child: TextButton(
                  onPressed: onConfirm,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16.0), // 버튼 높이를 증가
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white, // 글자색
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
