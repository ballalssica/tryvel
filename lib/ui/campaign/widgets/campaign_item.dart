import 'package:flutter/material.dart';

class CampaignItem extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final bool isReservationRequired; // 예약 필수 여부
  final bool isAvailableNow; // 바로 이용 여부

  const CampaignItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isReservationRequired = false,
    this.isAvailableNow = false,
  }) : super(key: key);

  @override
  _CampaignItemState createState() => _CampaignItemState();
}

class _CampaignItemState extends State<CampaignItem> {
  bool _isFavorite = false; // 별 아이콘 상태값

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16), // 여백 추가
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 및 별 아이콘
          Stack(
            children: [
              // 이미지
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 우측 상단 별 아이콘
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  child: Container(
                    width: 50, // 가로 사이즈
                    height: 50, // 세로 사이즈
                    color: Colors.transparent, // 투명 배경
                    alignment: Alignment.topRight, // 아이콘을 오른쪽 위로 정렬
                    child: Icon(
                      _isFavorite ? Icons.star : Icons.star_border,
                      color:
                          _isFavorite ? Colors.amber : Colors.amber, // 별 상태 색상
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12.0), // 이미지와 텍스트 간격

          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),

                // 설명
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                Spacer(),

                // 예약 필수, 바로 이용 상태
                Row(
                  children: [
                    if (widget.isReservationRequired)
                      _buildStatusContainer('예약 필수', true),
                    if (widget.isAvailableNow)
                      _buildStatusContainer('바로 이용 가능', false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 상태 표시용 텍스트 컨테이너 위젯
  Widget _buildStatusContainer(String text, bool isReservation) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color:
            isReservation ? Colors.amber : Colors.transparent, // 예약 필수: 앰버 배경
        borderRadius: BorderRadius.circular(4.0),
        border: isReservation
            ? null
            : Border.all(color: Colors.amber, width: 1.0), // 바로이용: 앰버 테두리
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isReservation
              ? Colors.white
              : Colors.amber, // 예약 필수: 화이트, 바로이용: 앰버
          fontSize: 10.0,
          fontWeight: FontWeight.normal, // 텍스트 스타일: 볼드 아님
        ),
      ),
    );
  }
}
