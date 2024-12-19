import 'package:flutter/material.dart';
import 'package:tryvel/ui/mypage/widgets/influencer_name_card.dart';
import 'package:tryvel/ui/widgets/divider_container.dart';

class MypageInfluencer extends StatelessWidget {
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
            InfluencerNameCard(),
            DividerContainer(),
          ],
        ),
      ),
    );
  }
}
