import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tryvel/data/repository/place_repository.dart';

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
class PlaceAddViewModel extends ChangeNotifier {
  final PlaceRepository _placeRepository = PlaceRepository();
  PlaceAddState _state = PlaceAddState();

  /// 상태 Getter
  PlaceAddState get state => _state;

  /// TextEditingController 정의
  final storeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressController = TextEditingController();
  final addressDetailController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumberController = TextEditingController();
  final storeDescriptionController = TextEditingController();

  /// 상태 업데이트 메서드들
  void updateStoreName(String value) {
    _state = _state.copyWith(storeName: value);
    notifyListeners();
  }

  void updateCategory(String value) {
    _state = _state.copyWith(category: value);
    notifyListeners();
  }

  void updateAddress(String value) {
    _state = _state.copyWith(address: value);
    notifyListeners();
  }

  void updateAddressDetail(String value) {
    _state = _state.copyWith(addressDetail: value);
    notifyListeners();
  }

  void updateHoliday(String value) {
    _state = _state.copyWith(holiday: value);
    notifyListeners();
  }

  void updateOperatingHours(String value) {
    _state = _state.copyWith(operatingHours: value);
    notifyListeners();
  }

  void updateParking(String value) {
    _state = _state.copyWith(parking: value);
    notifyListeners();
  }

  void updateStoreNumber(String value) {
    _state = _state.copyWith(storeNumber: value);
    notifyListeners();
  }

  void updateDescription(String value) {
    _state = _state.copyWith(description: value);
    notifyListeners();
  }

  /// 이미지 선택 및 업로드
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageUrl = await _uploadImage(pickedImage);
      if (imageUrl != null) {
        _state = _state.copyWith(imageUrl: imageUrl);
        notifyListeners(); // 상태 변경 알림
      }
    }
  }

  /// 이미지 업로드 메서드
  Future<String?> _uploadImage(XFile image) async {
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
    final operatingHours = _state.operatingHours.split('~');
    final openTime = operatingHours.isNotEmpty ? operatingHours[0].trim() : '';
    final closeTime = operatingHours.length > 1 ? operatingHours[1].trim() : '';

    return await _placeRepository.insert(
      name: _state.storeName,
      category: _state.category,
      address: _state.address,
      addressDetail: _state.addressDetail,
      holiday: _state.holiday,
      open: openTime,
      close: closeTime,
      tel: _state.storeNumber,
      description: _state.description,
      imageUrl: _state.imageUrl,
    );
  }
}
