import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tryvel/ui/place_add/widgets/registration_button%20.dart';
import 'package:tryvel/ui/widgets/form_field/place/address_search_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/holiday_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/image_uploder.dart';
import 'package:tryvel/ui/widgets/form_field/place/operating_hours_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/parking_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_description_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_name_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/category_dropdown_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_number_form_field.dart';

class PlaceAddPage extends StatefulWidget {
  @override
  _PlaceAddPageState createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  final storeNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressSearchController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumbercontroller = TextEditingController();
  final storeDescrptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    storeNameController.dispose();
    businessNameController.dispose();
    categoryController.dispose();
    addressSearchController.dispose();
    holidayController.dispose();
    operatingHoursController.dispose();
    parkingController.dispose();
    storeNumbercontroller.dispose();
    storeDescrptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이스 등록하기'),
      ),
      body: ListView(
        children: [
          ImageUploder(
            selectedImage: _selectedImage,
            onPickImage: _pickImage,
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        '상호명',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  StoreNameFormField(controller: storeNameController),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '카테고리',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  CategoryDropdownFormField(controller: categoryController),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '주소',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  AddressSearchFormField(
                    addressController: addressSearchController,
                    onCoordinatesSaved: (latitude, longitude) {
                      print('위도: $latitude, 경도: $longitude');
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '정기휴일',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  HolidayFormField(controller: holidayController),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '운영시간',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  OperatingHoursFormField(controller: operatingHoursController),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '주차가능여부',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ParkingFormField(controller: parkingController),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '매장 전화번호',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  StoreNumberFormField(controller: storeNumbercontroller),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        '매장 소개',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        ' *',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFFA000)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  StoreDescriptionFormField(
                      controller: storeDescrptionController),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: RegistrationButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('등록되었습니다!')),
            );
          }
        },
        label: '등록하기',
      ),
    );
  }
}
