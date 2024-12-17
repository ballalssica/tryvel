import 'package:flutter/material.dart';
import 'package:tryvel/ui/home/widgets/campain_list.dart';
import 'package:tryvel/ui/home/widgets/rolling_category_menu.dart';
import 'package:tryvel/ui/widgets/appbar_container.dart';
import 'package:tryvel/ui/widgets/button/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // 더미 데이터: 캠페인 리스트
  final List<Map<String, String>> campaigns = const [
    {'title': '캠페인 1', 'description': '캠페인 1 설명'},
    {'title': '캠페인 2', 'description': '캠페인 2 설명'},
    {'title': '캠페인 3', 'description': '캠페인 3 설명'},
    {'title': '캠페인 4', 'description': '캠페인 4 설명'},
    {'title': '캠페인 5', 'description': '캠페인 5 설명'},
    {'title': '캠페인 6', 'description': '캠페인 6 설명'}, // 최신 5개만 사용됨
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        title: const AppbarContainer(),
        automaticallyImplyLeading: false,
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
              '더보기',
              style: TextStyle(
                fontSize: 12, // 글자 크기 12
                color: Colors.grey, // 글자 색상 그레이
              ),
            ),
          ),

          Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),

          CampaignListWidget(campaigns: campaigns),

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
            height: 100,
          )
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
