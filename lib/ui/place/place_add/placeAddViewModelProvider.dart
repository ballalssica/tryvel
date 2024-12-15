import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tryvel/ui/place/place_add/place_add_view_model.dart';

// ViewModel Provider 정의
final placeAddViewModelProvider =
    StateNotifierProvider<PlaceAddViewModel, PlaceAddState>(
  (ref) => PlaceAddViewModel(),
);
