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
        borderRadius: BorderRadius.circular(10.0), // 팝업 모서리 둥글게
      ),
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
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                    side: const BorderSide(color: Colors.amber),
                  ),
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.amber,
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
                    backgroundColor: Colors.amber, // 배경색
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
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
