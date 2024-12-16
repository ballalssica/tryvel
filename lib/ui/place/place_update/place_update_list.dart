import 'package:flutter/material.dart';
import 'package:tryvel/data/repository/place_repository.dart';
import 'package:tryvel/data/model/place.dart';
import 'package:tryvel/ui/place/place_update/place_update_page.dart';

class PlaceUpdateList extends StatelessWidget {
  final PlaceRepository repository = PlaceRepository(); // 레포지토리 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이스 목록'),
      ),
      body: FutureBuilder<List<Place>?>(
        future: repository.getAll(), // 레포지토리의 getAll 메서드 사용
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('등록된 플레이스가 없습니다.'));
          }

          final places = snapshot.data!;
          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlaceUpdatePage(placeId: place.id),
                      ),
                    );
                  },
                  child: Text('${place.name}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
