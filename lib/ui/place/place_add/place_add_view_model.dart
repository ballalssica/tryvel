import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tryvel/data/repository/place_repository.dart';
import 'package:tryvel/core/utils/view_model_util.dart';

/// PlaceAddState 클래스 - 상태 관리
class PlaceAddState {
  final String storeName;
  final String category;
  final String address;
  final String addressDetail;
  final String holiday;
  final String operatingHours;
  final String parking;
  final String storeNumber;
  final String description;
  final String? imageUrl;

  PlaceAddState({
    this.storeName = '',
    this.category = '',
    this.address = '',
    this.addressDetail = '',
    this.holiday = '',
    this.operatingHours = '',
    this.parking = '',
    this.storeNumber = '',
    this.description = '',
    this.imageUrl,
  });

  /// 상태를 업데이트하는 copyWith 메서드
  PlaceAddState copyWith({
    String? storeName,
    String? category,
    String? address,
    String? addressDetail,
    String? holiday,
    String? operatingHours,
    String? parking,
    String? storeNumber,
    String? description,
    String? imageUrl,
  }) {
    return PlaceAddState(
      storeName: storeName ?? this.storeName,
      category: category ?? this.category,
      address: address ?? this.address,
      addressDetail: addressDetail ?? this.addressDetail,
      holiday: holiday ?? this.holiday,
      operatingHours: operatingHours ?? this.operatingHours,
      parking: parking ?? this.parking,
      storeNumber: storeNumber ?? this.storeNumber,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

/// PlaceAddViewModel 클래스 - 비즈니스 로직 관리
class PlaceAddViewModel {
  final PlaceRepository _placeRepository = PlaceRepository();
  PlaceAddState state = PlaceAddState();

  // TextEditingController 정의
  final storeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressController = TextEditingController();
  final addressDetailController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumberController = TextEditingController();
  final storeDescriptionController = TextEditingController();

  /// 초기 상태를 컨트롤러에 설정
  void initializeControllers(Map<String, dynamic> data) {
    ViewModelUtil.populateControllersFromMap(
      data,
      storeNameController: storeNameController,
      categoryController: categoryController,
      addressController: addressController,
      holidayController: holidayController,
      operatingHoursController: operatingHoursController,
      parkingController: parkingController,
      storeNumberController: storeNumberController,
      storeDescriptionController: storeDescriptionController,
    );
  }

  /// 이미지 선택 및 업로드
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageUrl = await uploadImage(pickedImage);
      if (imageUrl != null) {
        state = state.copyWith(imageUrl: imageUrl);
      }
    }
  }

  /// 이미지 업로드 메서드
  Future<String?> uploadImage(XFile image) async {
    try {
      final storage = FirebaseStorage.instance;
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      final Reference storageRef = storage.ref().child('places/$fileName');
      final UploadTask uploadTask = storageRef.putFile(File(image.path));
      final TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('이미지 업로드 실패: $e');
      return null;
    }
  }

  /// 플레이스 데이터 저장
  Future<bool> savePlace() async {
    final operatingHours = state.operatingHours.split('~');
    final openTime = operatingHours.isNotEmpty ? operatingHours[0].trim() : '';
    final closeTime = operatingHours.length > 1 ? operatingHours[1].trim() : '';

    return await _placeRepository.insert(
      name: state.storeName,
      category: state.category,
      address: state.address,
      addressDetail: state.addressDetail, // 추가
      holiday: state.holiday,
      open: openTime,
      close: closeTime,
      tel: state.storeNumber,
      description: state.description,
      imageUrl: state.imageUrl,
    );
  }

  /// 상태 업데이트 메서드들
  void updateStoreName(String value) =>
      state = state.copyWith(storeName: value);
  void updateCategory(String value) => state = state.copyWith(category: value);
  void updateAddress(String value) => state = state.copyWith(address: value);
  void updateAddressDetail(String value) =>
      state = state.copyWith(addressDetail: value);
  void updateHoliday(String value) => state = state.copyWith(holiday: value);
  void updateOperatingHours(String value) =>
      state = state.copyWith(operatingHours: value);
  void updateParking(String value) => state = state.copyWith(parking: value);
  void updateStoreNumber(String value) =>
      state = state.copyWith(storeNumber: value);
  void updateDescription(String value) =>
      state = state.copyWith(description: value);
}
