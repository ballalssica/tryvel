import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class PlaceUpdateViewModel {
  PlaceUpdateState state = PlaceUpdateState();

  final storeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumberController = TextEditingController();
  final storeDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _firestore = FirebaseFirestore.instance;
  final _picker = ImagePicker();

  Future<void> fetchPlaceData(String placeId) async {
    try {
      final docSnapshot =
          await _firestore.collection('place').doc(placeId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          storeNameController.text = data['name'] ?? '';
          categoryController.text = data['category'] ?? '';
          addressController.text = data['address'] ?? '';
          holidayController.text = data['holiday'] ?? '';
          operatingHoursController.text = '${data['open']} ~ ${data['close']}';
          parkingController.text = data['parking'] ?? '';
          storeNumberController.text = data['tel'] ?? '';
          storeDescriptionController.text = data['description'] ?? '';

          state = state.copyWith(imageUrl: data['imageUrl'], isLoading: false);
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print('Error fetching place data: $e');
      state = state.copyWith(isLoading: false);
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

  Future<bool> updatePlace(String placeId) async {
    if (formKey.currentState!.validate()) {
      try {
        await _firestore.collection('place').doc(placeId).update({
          'name': storeNameController.text,
          'category': categoryController.text,
          'address': addressController.text,
          'holiday': holidayController.text,
          'open': operatingHoursController.text.split('~')[0].trim(),
          'close': operatingHoursController.text.split('~')[1].trim(),
          'parking': parkingController.text,
          'tel': storeNumberController.text,
          'description': storeDescriptionController.text,
          'imageUrl': state.imageUrl,
        });
        return true;
      } catch (e) {
        print('Error updating place: $e');
        return false;
      }
    }
    return false;
  }
}
