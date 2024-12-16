import 'package:flutter/material.dart';

class ViewModelUtil {
  static void populateControllersFromMap(
    Map<String, dynamic> data, {
    required TextEditingController storeNameController,
    required TextEditingController categoryController,
    required TextEditingController addressController,
    required TextEditingController holidayController,
    required TextEditingController operatingHoursController,
    required TextEditingController parkingController,
    required TextEditingController storeNumberController,
    required TextEditingController storeDescriptionController,
  }) {
    storeNameController.text = data['name'] ?? '';
    categoryController.text = data['category'] ?? '';
    addressController.text = data['address'] ?? '';
    holidayController.text = data['holiday'] ?? '';
    operatingHoursController.text =
        '${data['open'] ?? ''} ~ ${data['close'] ?? ''}';
    parkingController.text = data['parking'] ?? '';
    storeNumberController.text = data['tel'] ?? '';
    storeDescriptionController.text = data['description'] ?? '';
  }
}
