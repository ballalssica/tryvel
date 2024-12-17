import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tryvel/data/repository/place_repository.dart';
import 'package:tryvel/ui/place/place_add/place_add_state.dart';

class PlaceViewModel extends ChangeNotifier {
  final PlaceRepository _placeRepository = PlaceRepository();
  PlaceAddState _state = PlaceAddState();
  bool _isLoading = false;

  PlaceAddState get state => _state;
  bool get isLoading => _isLoading;

  final storeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressController = TextEditingController();
  final addressDetailController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumberController = TextEditingController();
  final storeDescriptionController = TextEditingController();

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

  void updateCoordinates(double latitude, double longitude) {
    _state = _state.copyWith(latitude: latitude, longitude: longitude);
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageUrl = await _uploadImage(pickedImage);
      if (imageUrl != null) {
        _state = _state.copyWith(imageUrl: imageUrl);
        notifyListeners();
      }
    }
  }

  Future<String?> _uploadImage(XFile image) async {
    try {
      final storage = FirebaseStorage.instance;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      final ref = storage.ref().child('places/$fileName');
      final snapshot = await ref.putFile(File(image.path));
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<bool> savePlace() async {
    try {
      _isLoading = true;
      notifyListeners();
      final operatingHours = _state.operatingHours.split('~');
      await _placeRepository.insert(
        name: _state.storeName,
        category: _state.category,
        address: _state.address,
        addressDetail: _state.addressDetail,
        holiday: _state.holiday,
        open: operatingHours[0].trim(),
        close: operatingHours.length > 1 ? operatingHours[1].trim() : '',
        tel: _state.storeNumber,
        description: _state.description,
        imageUrl: _state.imageUrl,
        latitude: _state.latitude,
        longitude: _state.longitude,
        parking: _state.parking,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error saving place: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePlace(String placeId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final operatingHours = _state.operatingHours.split('~');
      await _placeRepository.update(
        id: placeId,
        name: _state.storeName,
        category: _state.category,
        address: _state.address,
        addressDetail: _state.addressDetail,
        holiday: _state.holiday,
        open: operatingHours[0].trim(),
        close: operatingHours.length > 1 ? operatingHours[1].trim() : '',
        tel: _state.storeNumber,
        description: _state.description,
        imageUrl: _state.imageUrl,
        latitude: _state.latitude,
        longitude: _state.longitude,
        parking: _state.parking,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating place: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchPlaceData(String placeId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final place = await _placeRepository.getOne(placeId);
      if (place != null) {
        _state = PlaceAddState(
          storeName: place.name,
          category: place.category,
          address: place.address,
          addressDetail: place.addressDetail ?? '',
          holiday: place.holiday,
          operatingHours: '${place.open} ~ ${place.close}',
          parking: place.parking,
          storeNumber: place.tel,
          description: place.description,
          imageUrl: place.imageUrl,
          latitude: place.latitude,
          longitude: place.longitude,
        );
        storeNameController.text = _state.storeName;
        categoryController.text = _state.category;
        addressController.text = _state.address;
        addressDetailController.text = _state.addressDetail;
        holidayController.text = _state.holiday;
        operatingHoursController.text = _state.operatingHours;
        parkingController.text = _state.parking;
        storeNumberController.text = _state.storeNumber;
        storeDescriptionController.text = _state.description;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching place data: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
}
