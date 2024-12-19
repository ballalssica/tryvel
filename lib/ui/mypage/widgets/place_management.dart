import 'package:flutter/material.dart';
import 'package:tryvel/data/repository/place_repository.dart';
import 'package:tryvel/data/model/place.dart';
import 'package:tryvel/ui/place/place_update/place_update_page.dart';
import 'package:tryvel/ui/place/place_add/place_add_page.dart';
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
        Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded; // 확장/축소 상태 변경
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFF5F5F5),
                    width: 1.0, // 경계선 두께
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      '플레이스 관리',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),

        // 리스트가 확장되면 플레이스 데이터 표시
        if (_isExpanded)
          Column(
            children: [
              ...List.generate(_places.length, (index) {
                final place = _places[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8),
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFD6D6D6),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              color: Colors.amber,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  place.name,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
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
                                backgroundColor: const Color(0xFF4A4A4A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                              ),
                              child: const Text(
                                '수정',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TwoButtonPopup(
                                        content: Text(
                                          '${place.name}을 삭제하시겠습니까?',
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                        ),
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        onConfirm: () async {
                                          final success =
                                              await _deletePlace(place.id);
                                          if (success) {
                                            Navigator.of(context).pop();
                                          } else {
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
                                    color: Color(0xFF4A4A4A),
                                    width: 1.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                ),
                                child: const Text(
                                  '삭제',
                                  style: TextStyle(
                                    color: Color(0xFF4A4A4A),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceAddPage(),
                    ),
                  ).then((added) {
                    if (added == true) {
                      _fetchPlaces(); // 데이터 새로고침
                    }
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
      ],
    );
  }
}
