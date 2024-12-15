import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tryvel/data/model/place.dart';

class PlaceRepository {
  // Firestore 데이터를 불러오는 메서드
  Future<List<Place>?> getAll() async {
    try {
      // 1. Firestore 인스턴스 가져오기
      final firestore = FirebaseFirestore.instance;

      // 2. 'place' 컬렉션 참조 만들기
      final collectionRef = firestore.collection('place');

      // 3. 값 불러오기
      final result = await collectionRef.get();
      final docs = result.docs;
      return docs.map(
        (doc) {
          final map = doc.data();
          doc.id;
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
    required String holiday,
    required String open, // 00:00 형식
    required String close, // 00:00 형식
    required String tel,
    required String description,
    String? imageUrl,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('place');
      final docRef = collectionRef.doc();

      // open과 close를 String으로 그대로 저장
      await docRef.set({
        'name': name,
        'category': category,
        'address': address,
        'holiday': holiday,
        'open': open, // 문자열로 저장
        'close': close, // 문자열로 저장
        'tel': tel,
        'description': description,
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

// 2. Read : 특정ID로 하나의 도큐먼트 가져오기
Future<Place?> getOne(String id) async {
  try {
    // 1) 파이어스토어 인스턴스 가지고 오기
    final firestore = FirebaseFirestore.instance;
    // 2) 컬렉션 참조만들기
    final collectionRef = firestore.collection('place');
    // 3) 문서 참조 만들기
    final docRef = collectionRef.doc(id);
    // 4) 값 읽기
    final doc = await docRef.get();
    return Place.fromJson({
      'id': doc.id,
      ...doc.data()!,
    });
  } catch (e) {
    print(e);
    return null;
  }
}

// 3. UPdate : 도큐먼트 수정
Future<bool> update({
  required String id,
  required String name,
  required String category,
  required String address,
  required String holiday,
  required String open,
  required String close,
  required String tel,
  required String description,
  String? imageUrl,
}) async {
  try {
    // 1) 파이어스토어 인스턴스 가지고 오기
    final firestore = FirebaseFirestore.instance;
    // 2) 컬렉션 참조만들기
    final collectionRef = firestore.collection('place');
    // 3) 문서 참조 만들기
    final docRef = collectionRef.doc(id);
    // 4) 값수정
    await docRef.update({
      'name': name,
      'category': category,
      'address': address,
      'holiday': holiday,
      'open': open,
      'close': close,
      'tel': tel,
      'description': description,
      'imageUrl': imageUrl,
    });
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

// 4. Delete : 도큐먼트 삭제
Future<bool> delete(String id) async {
  try {
    // 1) 파이어스토어 인스턴스 가지고 오기
    final firestore = FirebaseFirestore.instance;
    // 2) 컬렉션 참조만들기
    final collectionRef = firestore.collection('place');
    // 3) 문서 참조 만들기
    final docRef = collectionRef.doc(id);
    // 4) 삭제
    await docRef.delete();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

    // 1) 파이어스토어 인스턴스 가지고 오기
    // final firestore = FirebaseFirestore.instance;
    // 2) 컬렉션 참조만들기
    // final collectionRef = firestore.collection('');
    // 3) 문서 참조 만들기
    