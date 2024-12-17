import 'package:flutter/material.dart';
import 'package:tryvel/data/repository/place_repository.dart';
import 'package:tryvel/data/model/place.dart';
import 'package:tryvel/ui/place/place_update/place_update_page.dart';

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

  void _deletePlace(String id) async {
    final repository = PlaceRepository();
    final success = await repository.delete(id);
    if (success) {
      _fetchPlaces(); // 삭제 후 리스트 갱신
    }
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
                  color: Colors.grey,
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
            children: _places.map((place) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // 플레이스 이름
                    Expanded(
                      child: Text(
                        place.name,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    // 수정 버튼
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlaceUpdatePage(place: place), // Place 객체 넘겨주기
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
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
                        _deletePlace(place.id); // 삭제 기능
                      },
                      style: TextButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.amber,
                          width: 1.0,
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
              );
            }).toList(),
          ),
      ],
    );
  }
}
