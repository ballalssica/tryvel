import 'package:flutter/material.dart';
import 'package:tryvel/ui/home/widgets/campain_list.dart';
import 'package:tryvel/ui/home/widgets/rolling_category_menu.dart';
import 'package:tryvel/ui/widgets/appbar_container.dart';
import 'package:tryvel/ui/widgets/button/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // 더미 데이터: 캠페인 리스트
  final List<Map<String, dynamic>> dummyCampaigns = [
    {
      'title': '캠페인 1',
      'description': '이 캠페인은 지역 홍보를 위한 이벤트입니다.',
      'imageUrl': 'https://picsum.photos/50/50?1',
      'isReservationRequired': true, // 예약 필수 여부
      'isAvailableNow': false, // 바로 이용 가능 여부
      'isFavorite': false, // 별 아이콘 상태
    },
    {
      'title': '캠페인 2',
      'description': '친환경 캠페인에 동참하세요.',
      'imageUrl': 'https://picsum.photos/50/50?2',
      'isReservationRequired': true,
      'isAvailableNow': true,
      'isFavorite': true,
    },
    {
      'title': '캠페인 3',
      'description': '오늘부터 바로 이용 가능한 캠페인입니다.',
      'imageUrl': 'https://picsum.photos/50/50?3',
      'isReservationRequired': false,
      'isAvailableNow': true,
      'isFavorite': false,
    },
    {
      'title': '캠페인 4',
      'description': '한정판 혜택이 제공되는 특별 캠페인입니다.',
      'imageUrl': 'https://picsum.photos/50/50?4',
      'isReservationRequired': true,
      'isAvailableNow': false,
      'isFavorite': true,
    },
    {
      'title': '캠페인 5',
      'description': '전국적으로 진행되는 대규모 이벤트.',
      'imageUrl': 'https://picsum.photos/50/50?5',
      'isReservationRequired': false,
      'isAvailableNow': false,
      'isFavorite': false,
    },
    {
      'title': '캠페인 6',
      'description': '현장에서 바로 참여 가능한 캠페인.',
      'imageUrl': 'https://picsum.photos/50/50?6',
      'isReservationRequired': false,
      'isAvailableNow': true,
      'isFavorite': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색 고정
        toolbarHeight: 60,
        title: const AppbarContainer(), // 앱바 내부 위젯
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 제거
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          // 이미지 배너
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/200/300'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),

          // 롤링 카테고리 메뉴
          RollingCategoryMenu(),
          Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),
          const SizedBox(height: 10),

          Container(
            color: Colors.white,
            alignment: Alignment.centerRight, // 오른쪽 정렬
            padding: const EdgeInsets.all(16.0), // 전체 패딩 16
            child: const Text(
              '더보기 >',
              style: TextStyle(
                fontSize: 12, // 글자 크기 12
                color: const Color(0xFF4A4A4A), // 글자 색상 그레이
              ),
            ),
          ),

          CampaignList(campaigns: dummyCampaigns),

          // 간격용 배경색
          Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),

          Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey[100],
          ),
          Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
