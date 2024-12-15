import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:tryvel/data/repository/place_repository.dart';

// 상태 클래스
class PlaceAddState {
  final String storeName;
  final String category;
  final String address;
  final String holiday;
  final String operatingHours;
  final String parking;
  final String storeNumber;
  final String description;
  final XFile? selectedImage;

  PlaceAddState({
    this.storeName = '',
    this.category = '',
    this.address = '',
    this.holiday = '',
    this.operatingHours = '',
    this.parking = '',
    this.storeNumber = '',
    this.description = '',
    this.selectedImage,
  });

  PlaceAddState copyWith({
    String? storeName,
    String? category,
    String? address,
    String? holiday,
    String? operatingHours,
    String? parking,
    String? storeNumber,
    String? description,
    XFile? selectedImage,
  }) {
    return PlaceAddState(
      storeName: storeName ?? this.storeName,
      category: category ?? this.category,
      address: address ?? this.address,
      holiday: holiday ?? this.holiday,
      operatingHours: operatingHours ?? this.operatingHours,
      parking: parking ?? this.parking,
      storeNumber: storeNumber ?? this.storeNumber,
      description: description ?? this.description,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

// ViewModel 클래스
class PlaceAddViewModel extends StateNotifier<PlaceAddState> {
  final PlaceRepository _placeRepository = PlaceRepository();

  PlaceAddViewModel() : super(PlaceAddState());

  // 이미지 선택
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      state = state.copyWith(selectedImage: pickedImage);
    }
  }

  // 이미지 업로드 및 URL 반환
  Future<String?> uploadImage(XFile image) async {
    try {
      final String fileName = basename(image.path); // 파일 이름 추출
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('places/$fileName'); // Firebase Storage 경로 설정
      final UploadTask uploadTask = storageRef.putFile(File(image.path));
      final TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL(); // 업로드된 파일의 URL 반환
    } catch (e) {
      print('이미지 업로드 실패: $e');
      return null;
    }
  }

  // 데이터 저장
  Future<bool> savePlace() async {
    String? imageUrl;
    if (state.selectedImage != null) {
      imageUrl = await uploadImage(state.selectedImage!); // 이미지 업로드 및 URL 가져오기
    }

    final operatingHours = state.operatingHours.split('~');
    final openTime = operatingHours.isNotEmpty ? operatingHours[0].trim() : '';
    final closeTime = operatingHours.length > 1 ? operatingHours[1].trim() : '';

    return await _placeRepository.insert(
      name: state.storeName,
      category: state.category,
      address: state.address,
      holiday: state.holiday,
      open: openTime,
      close: closeTime,
      tel: state.storeNumber,
      description: state.description,
      imageUrl: imageUrl, // 업로드된 이미지의 URL 저장
    );
  }

  // 상태 업데이트 메서드
  void updateStoreName(String value) {
    state = state.copyWith(storeName: value);
  }

  void updateCategory(String value) {
    state = state.copyWith(category: value);
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value);
  }

  void updateHoliday(String value) {
    state = state.copyWith(holiday: value);
  }

  void updateOperatingHours(String value) {
    state = state.copyWith(operatingHours: value);
  }

  void updateParking(String value) {
    state = state.copyWith(parking: value);
  }

  void updateStoreNumber(String value) {
    state = state.copyWith(storeNumber: value);
  }

  void updateDescription(String value) {
    state = state.copyWith(description: value);
  }
}
