import 'package:flutter/material.dart';
import 'package:tryvel/data/repository/place_repository.dart';
import 'package:tryvel/data/model/place.dart';
import 'package:tryvel/ui/place/place_update/place_update_page.dart';
import 'package:tryvel/ui/widgets/popup/two_button_popup.dart';

class PlaceManagement extends StatefulWidget {
  const PlaceManagement({Key? key}) : super(key: key);

  @override
  _PlaceManagementState createState() => _PlaceManagementState();
}

class _PlaceManagementState extends State<PlaceManagement> {
  bool _isExpanded = false; // 리스트 확장/축소 상태
  List<Place> _places = []; // Firestore에서 가져올 플레이스 리스트

  @override
  void initState() {
    super.initState();
    _fetchPlaces(); // 플레이스 데이터 불러오기
  }

  Future<void> _fetchPlaces() async {
    final repository = PlaceRepository();
    final result = await repository.getAll();
    if (result != null) {
      setState(() {
        _places = result;
      });
    }
  }

  // 삭제 함수: 삭제 성공 여부를 반환
  Future<bool> _deletePlace(String id) async {
    final repository = PlaceRepository();
    final success = await repository.delete(id);
    if (success) {
      await _fetchPlaces(); // 삭제 후 리스트 갱신
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 상단 타이틀 영역
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded; // 확장/축소 상태 변경
            });
          },
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '플레이스 관리',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '플레이스를 등록하고 정보를 수정할 수 있어요.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.amber,
                  size: 30,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),

        // 리스트가 확장되면 플레이스 데이터 표시
        if (_isExpanded)
          Column(
            children: List.generate(_places.length, (index) {
              final place = _places[index];
              return Column(
                children: [
                  Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // 플레이스 이름
                        Expanded(
                          child: Text(
                            place.name,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ),
                        // 수정 버튼
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlaceUpdatePage(place: place),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          child: const Text(
                            '수정',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // 삭제 버튼
                        TextButton(
                          onPressed: () {
                            // 팝업 호출
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TwoButtonPopup(
                                  content: Text(
                                    '${place.name}을 삭제하시겠습니까?',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                  onCancel: () {
                                    Navigator.of(context).pop(); // 팝업 닫기
                                  },
                                  onConfirm: () async {
                                    final success =
                                        await _deletePlace(place.id);
                                    if (success) {
                                      Navigator.of(context)
                                          .pop(); // 삭제 성공 시 팝업 닫기
                                    } else {
                                      // 실패 처리 (로그 출력 또는 알림)
                                      print('삭제 실패');
                                    }
                                  },
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.amber,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                          ),
                          child: const Text(
                            '삭제',
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Divider 추가 (마지막 요소는 제외)
                  if (index != _places.length - 1)
                    const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                      height: 0.0,
                    ),
                ],
              );
            }),
          ),
      ],
    );
  }
}
