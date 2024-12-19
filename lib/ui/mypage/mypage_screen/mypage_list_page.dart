import 'package:flutter/material.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_business.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_influencer.dart';
import 'package:tryvel/ui/mypage/mypage_screen/mypage_screen_page.dart';
import 'package:tryvel/ui/widgets/button/amberbotton.dart';

class MypageListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 기존 마이페이지
            AmberElevatedButton(
              buttonText: '마이페이지_기존',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageScreenPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),

            // 사업자 마이페이지
            AmberElevatedButton(
              buttonText: '마이페이지_사업자',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageBusiness(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),

            //인플루언서 마이페이지

            AmberElevatedButton(
              buttonText: '마이페이지_인플루언서',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MypageInfluencer(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
