import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tryvel/data/repository/place_repository.dart';

class PlaceAddState {
  final String storeName;
  final String category;
  final String address;
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
    this.holiday = '',
    this.operatingHours = '',
    this.parking = '',
    this.storeNumber = '',
    this.description = '',
    this.imageUrl,
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
    String? imageUrl,
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
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class PlaceAddViewModel extends StateNotifier<PlaceAddState> {
  final PlaceRepository _placeRepository = PlaceRepository();

  PlaceAddViewModel() : super(PlaceAddState());

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

  Future<bool> savePlace() async {
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
      imageUrl: state.imageUrl,
    );
  }

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
