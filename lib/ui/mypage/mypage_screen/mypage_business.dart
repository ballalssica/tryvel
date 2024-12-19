import 'package:flutter/material.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_list_page.dart';
import 'package:tryvel/ui/mypage/widgets/business_name_card.dart';
import 'package:tryvel/ui/mypage/widgets/place_management.dart';
import 'package:tryvel/ui/widgets/button/content_button.dart';
import 'package:tryvel/ui/widgets/divider_container.dart';

class MypageBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 자식 위젯이 필요한 만큼만 공간 차지
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BusinessNameCard(),
            SizedBox(height: 10),
            PlaceManagement(),
            ContentButton(
              icon: Icons.edit_note,
              text: '캠페인 관리',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageListPage(),
                  ),
                );
              },
            ),
            ContentButton(
              icon: Icons.how_to_reg,
              text: '협업 관리',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageListPage(),
                  ),
                );
              },
            ),
            ContentButton(
              icon: Icons.notifications,
              text: '알림',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageListPage(),
                  ),
                );
              },
            ),
            ContentButton(
              icon: Icons.question_answer,
              text: '톡톡',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageListPage(),
                  ),
                );
              },
            ),
            ContentButton(
              icon: Icons.mail,
              text: '1:1 문의',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageListPage(),
                  ),
                );
              },
            ),
            DividerContainer(),
          ],
        ),
      ),
    );
  }
}
