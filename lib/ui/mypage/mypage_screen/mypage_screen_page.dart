import 'package:flutter/material.dart';
import 'package:tryvel/ui/mypage/mypage_screen/widgets/campaign_registration.dart';
import 'package:tryvel/ui/mypage/mypage_screen/widgets/place_management.dart';

class MypageScreenPage extends StatelessWidget {
  final String imageUrl = 'https://picsum.photos/200'; // 동그란 사진 URL (더미 이미지)
  final String name = '김민지'; // 이름
  final String introduction = '소개글입니다.'; // 소개글

  const MypageScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // 빈 AppBar
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 동그란 이미지
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0), // 간격
                    // 이름과 소개글
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          introduction,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // 컨테이너 박스
                Container(
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
                            '캠페인 신청내역',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '캠페인 신청과 진행내용을 확인하세요.',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // 왼쪽에 꼬리 없는 화살표 아이콘
                      const Icon(
                        Icons.keyboard_arrow_right, // 꼬리 없는 화살표 아이콘
                        color: Colors.grey,
                        size: 30,
                      ),
                      const SizedBox(width: 8), // 간격
                    ],
                  ),
                ),
                CampaignRegistration(),
                PlaceManagement(),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
