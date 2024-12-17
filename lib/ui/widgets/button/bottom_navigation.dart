import 'package:flutter/material.dart';
import 'package:tryvel/ui/home/home_page.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_screen_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // 네비게이션 바 배경색
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 그림자 색상 (투명도 적용)
            spreadRadius: 0, // 그림자 확산 정도
            blurRadius: 10, // 그림자 흐림 정도
            offset: const Offset(0, -3), // 그림자 위치 (위쪽 방향)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // 아이템 간격 균등 배치
        children: [
          _buildNavItem(
            context,
            icon: Icons.home,
            label: '홈',
            page: HomePage(),
          ),
          _buildNavItem(
            context,
            icon: Icons.near_me,
            label: '지도검색',
            page: MypageScreenPage(),
          ),
          _buildNavItem(
            context,
            icon: Icons.star,
            label: '찜',
            page: MypageScreenPage(),
          ),
          _buildNavItem(
            context,
            icon: Icons.person,
            label: '마이',
            page: MypageScreenPage(),
          ),
        ],
      ),
    );
  }

  // 네비게이션 바 아이템 위젯
  Widget _buildNavItem(BuildContext context,
      {required IconData icon, required String label, required Widget page}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 50), // 최소 사이즈 설정
        padding: const EdgeInsets.symmetric(vertical: 8.0), // 상하 패딩
        color: Colors.transparent, // 투명 배경
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF4A4A4A), size: 24), // 아이콘 스타일 설정
            const SizedBox(height: 4), // 아이콘과 텍스트 간격
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF4A4A4A), // 텍스트 색상
              ),
            ),
          ],
        ),
      ),
    );
  }
}
