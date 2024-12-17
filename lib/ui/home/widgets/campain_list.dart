import 'package:flutter/material.dart';
import 'package:tryvel/ui/widgets/campaign_item.dart';

class CampaignListWidget extends StatelessWidget {
  // 외부에서 데이터를 주입받을 수 있도록 파라미터 추가
  final List<Map<String, String>> campaigns;

  const CampaignListWidget({
    Key? key,
    required this.campaigns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 최신 5개의 캠페인만 가져오기
    final latestCampaigns = campaigns.take(5).toList();

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: latestCampaigns.map((campaign) {
          return SizedBox(
            height: 150,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: const Color(0xFFEEEEEE), width: 1.0),
                ),
              ),
              child: CampaignItem(
                title: campaign['title'] ?? '제목 없음',
                description: campaign['description'] ?? '설명 없음',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
