import 'package:flutter/material.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_screen_page.dart';

class AppbarContainer extends StatelessWidget implements PreferredSizeWidget {
  const AppbarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // AppBar 배경색
      child: Row(
        children: [
          // 활동지역 텍스트
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MypageScreenPage()),
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 45,
              color: Colors.transparent, // 투명 배경
              child: const Text(
                '활동지역',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(), // 여백 추가

          // 종 아이콘
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MypageScreenPage()),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              color: Colors.transparent, // 투명 배경
              child: const Icon(Icons.notifications, color: Colors.grey),
            ),
          ),

          // 검색 아이콘
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MypageScreenPage()),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              color: Colors.transparent, // 투명 배경
              child: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0); // AppBar 높이 설정
}
