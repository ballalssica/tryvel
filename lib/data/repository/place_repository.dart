import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tryvel/data/model/place.dart';

class PlaceRepository {
  // Firestore 데이터를 불러오는 메서드
  Future<List<Place>?> getAll() async {
    try {
      // Firestore 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;

      // 'place' 컬렉션 참조 만들기
      final collectionRef = firestore.collection('place');

      // 값 불러오기
      final result = await collectionRef.get();
      final docs = result.docs;
      return docs.map(
        (doc) {
          final map = doc.data();
          final newMap = {
            'id': doc.id,
            ...map,
          };
          return Place.fromJson(newMap);
        },
      ).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 데이터 쓰기
  Future<bool> insert({
    required String name,
    required String category,
    required String address,
    String? addressDetail,
    required String holiday,
    required String open,
    required String close,
    required String tel,
    required String description,
    required String parking,
    double latitude = 0.0,
    double longitude = 0.0,
    Timestamp? timestamp,
    String? imageUrl,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('place');
      final docRef = collectionRef.doc();

      // 데이터 저장
      await docRef.set({
        'name': name,
        'category': category,
        'address': address,
        'addressDetail': addressDetail,
        'holiday': holiday,
        'open': open,
        'close': close,
        'tel': tel,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp ?? Timestamp.now(),
        'imageUrl': imageUrl,
        'parking': parking,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 특정 ID로 하나의 도큐먼트 가져오기
  Future<Place?> getOne(String id) async {
    try {
      // Firestore 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('place');
      final docRef = collectionRef.doc(id);
      final doc = await docRef.get();

      if (doc.exists) {
        return Place.fromJson({
          'id': doc.id,
          ...doc.data()!,
        });
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 도큐먼트 수정
  Future<bool> update({
    required String id,
    required String name,
    required String category,
    required String address,
    String? addressDetail,
    required String holiday,
    required String open,
    required String close,
    required String tel,
    required String description,
    required String parking,
    double latitude = 0.0,
    double longitude = 0.0,
    Timestamp? timestamp,
    String? imageUrl,
  }) async {
    try {
      // Firestore 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('place');
      final docRef = collectionRef.doc(id);

      // 값 수정
      await docRef.update({
        'name': name,
        'category': category,
        'address': address,
        'addressDetail': addressDetail,
        'holiday': holiday,
        'open': open,
        'close': close,
        'tel': tel,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp ?? Timestamp.now(),
        'imageUrl': imageUrl,
        'parking': parking,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 도큐먼트 삭제
  Future<bool> delete(String id) async {
    try {
      // Firestore 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('place');
      final docRef = collectionRef.doc(id);

      // 삭제
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
