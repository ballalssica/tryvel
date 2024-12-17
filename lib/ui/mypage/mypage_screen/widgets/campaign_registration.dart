import 'package:flutter/material.dart';
import 'package:tryvel/ui/place/place_add/place_add_page.dart';

class CampaignRegistration extends StatelessWidget {
  const CampaignRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 클릭했을 때 PlaceAddPage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlaceAddPage()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE0E0E0), // grey[100] 라인 색상
              width: 1.0, // 라인 두께
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 텍스트 영역
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '플레이스 등록',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '플레이스를 등록하고 정보를 수정할 수 있어요.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(), // 빈 공간 채우기

            // 오른쪽에 꼬리 없는 화살표 아이콘
            const Icon(
              Icons.keyboard_arrow_right, // 꼬리 없는 화살표 아이콘
              color: Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 8), // 아이콘과 끝 사이의 간격
          ],
        ),
      ),
    );
  }
}
