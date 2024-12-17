import 'package:flutter/material.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_screen_page.dart';

class RollingCategoryMenu extends StatelessWidget {
  // 카테고리 리스트 (링크 URL 추가)
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.list,
      'name': '전체',
      'link': MypageScreenPage(),
    },
    {
      'icon': Icons.home,
      'name': '숙소',
      'link': MypageScreenPage(),
    },
    {
      'icon': Icons.restaurant,
      'name': '맛집',
      'link': MypageScreenPage(),
    },
    {
      'icon': Icons.local_cafe,
      'name': '카페',
      'link': MypageScreenPage(),
    },
    {
      'icon': Icons.surfing,
      'name': '레저',
      'link': MypageScreenPage(),
    },
    {
      'icon': Icons.more_horiz,
      'name': '기타',
      'link': MypageScreenPage(),
    },
  ];

  RollingCategoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final icon = category['icon'] ?? Icons.category;
          final name = category['name'] ?? '이름 없음';
          final link = category['link'];

          return GestureDetector(
            onTap: () {
              if (link != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => link),
                );
              }
            },
            child: Container(
              width: 75,
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD6D6D6), // 아이템 배경 색상
                borderRadius: BorderRadius.circular(8), // 둥근 테두리 설정
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 상하 중앙 정렬
                children: [
                  Icon(
                    icon,
                    size: 24, // 아이콘 크기
                    color: const Color(0xFF4A4A4A), // 아이콘 색상
                  ),
                  const SizedBox(height: 4), // 아이콘과 텍스트 간격
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 10, // 텍스트 사이즈
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4A4A4A), // 텍스트 색상
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
