import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tryvel/data/model/place.dart';

// 1. 상태클래스 만들기
//List<Place>
// 2. 뷰모델 만들기

class PlaceAddViewModel extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [];
  }
}

// 3. 뷰모델 관리자 만들기