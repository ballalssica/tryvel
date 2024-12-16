import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final placeUpdateViewModelProvider = StateNotifierProvider.family<
    PlaceUpdateViewModel, PlaceUpdateState, String>(
  (ref, placeId) => PlaceUpdateViewModel(placeId),
);

class PlaceUpdateState {
  final String? imageUrl;
  final bool isLoading;

  PlaceUpdateState({this.imageUrl, this.isLoading = true});

  PlaceUpdateState copyWith({String? imageUrl, bool? isLoading}) {
    return PlaceUpdateState(
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PlaceUpdateViewModel extends StateNotifier<PlaceUpdateState> {
  final String placeId;

  final storeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressSearchController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumberController = TextEditingController();
  final storeDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _firestore = FirebaseFirestore.instance;
  final _picker = ImagePicker();

  PlaceUpdateViewModel(this.placeId) : super(PlaceUpdateState()) {
    _fetchPlaceData();
  }

  Future<void> _fetchPlaceData() async {
    try {
      final docSnapshot =
          await _firestore.collection('place').doc(placeId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          storeNameController.text = data['name'] ?? '';
          categoryController.text = data['category'] ?? '';
          addressSearchController.text = data['address'] ?? '';
          holidayController.text = data['holiday'] ?? '';
          operatingHoursController.text =
              '${data['open'] ?? ''} ~ ${data['close'] ?? ''}';
          parkingController.text = data['parking'] ?? '';
          storeNumberController.text = data['tel'] ?? '';
          storeDescriptionController.text = data['description'] ?? '';

          state = state.copyWith(
            imageUrl: data['imageUrl'],
            isLoading: false, // 데이터 로드 완료
          );
        }
      } else {
        state = state.copyWith(isLoading: false); // 문서가 없을 경우 로딩 해제
      }
    } catch (e) {
      print('Error fetching place data: $e');
      state = state.copyWith(isLoading: false); // 에러 발생 시 로딩 해제
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageUrl = await _uploadImageToStorage(pickedImage);
      if (imageUrl != null) {
        state = state.copyWith(imageUrl: imageUrl);
      }
    }
  }

  Future<String?> _uploadImageToStorage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'places/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
      final uploadTask = storageRef.putFile(File(image.path));
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('이미지 업로드 실패: $e');
      return null;
    }
  }

  Future<void> updatePlace() async {
    if (formKey.currentState!.validate()) {
      try {
        await _firestore.collection('place').doc(placeId).update({
          'name': storeNameController.text,
          'category': categoryController.text,
          'address': addressSearchController.text,
          'holiday': holidayController.text,
          'open': operatingHoursController.text.split('~')[0].trim(),
          'close': operatingHoursController.text.split('~')[1].trim(),
          'parking': parkingController.text,
          'tel': storeNumberController.text,
          'description': storeDescriptionController.text,
          'imageUrl': state.imageUrl,
        });
      } catch (e) {
        print('Error updating place: $e');
      }
    }
  }
}
