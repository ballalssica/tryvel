import 'package:flutter/material.dart';
import 'package:tryvel/ui/widgets/campaign_item.dart';

class CampaignList extends StatelessWidget {
  // 외부에서 데이터를 주입받을 수 있도록 파라미터 추가
  final List<Map<String, dynamic>> campaigns;

  const CampaignList({
    Key? key,
    required this.campaigns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 최신 5개의 캠페인만 가져오기
    final latestCampaigns = campaigns.take(5).toList();

    return Container(
      color: Colors.white, // 전체 배경색
      child: Column(
        children: latestCampaigns.map((campaign) {
          return Container(
            height: 150, // 캠페인 아이템 높이 설정
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color(0xFFEEEEEE), width: 1.0), // 위쪽 그레이 선
                bottom: BorderSide(
                    color: Color(0xFFEEEEEE), width: 1.0), // 아래쪽 그레이 선
              ),
            ),
            child: CampaignItem(
              title: campaign['title'] ?? '제목 없음',
              description: campaign['description'] ?? '설명 없음',
              imageUrl:
                  campaign['imageUrl'] ?? 'https://via.placeholder.com/50',
              isReservationRequired: campaign['isReservationRequired'] ?? false,
              isAvailableNow: campaign['isAvailableNow'] ?? false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
