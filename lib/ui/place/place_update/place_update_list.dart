import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tryvel/ui/place/place_update/place_update_page.dart';
import 'package:tryvel/data/model/place.dart';

class PlaceUpdateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이스 목록'),
      ),
      body: FutureBuilder<List<Place>?>(
        future: _fetchPlaces(), // Firestore에서 데이터 가져오기
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
                  child: Text(place.name), // 버튼 텍스트에 Place 이름 표시
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Place>> _fetchPlaces() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('place');
      final querySnapshot = await collectionRef.get();

      print('Documents fetched: ${querySnapshot.docs.length}');
      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      });

      return querySnapshot.docs.map((doc) {
        final data = doc.data();

        return Place(
          id: doc.id,
          name: data['name'] ?? '',
          category: data['category'] ?? '',
          address: data['address'] ?? '',
          holiday: data['holiday'] ?? '',
          open: _parseTimeField(data['open']), // `open` 필드 처리
          close: _parseTimeField(data['close']), // `close` 필드 처리
          tel: data['tel'] ?? '',
          description: data['description'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching places: $e');
      return [];
    }
  }

  String _parseTimeField(dynamic timeField) {
    if (timeField is String) {
      return timeField; // `String`인 경우 그대로 반환
    } else if (timeField is Timestamp) {
      final dateTime = timeField.toDate();
      final hours = dateTime.hour.toString().padLeft(2, '0');
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      return '$hours:$minutes'; // `Timestamp`인 경우 "HH:mm" 형식으로 변환
    } else {
      return ''; // 알 수 없는 경우 빈 문자열 반환
    }
  }
}
