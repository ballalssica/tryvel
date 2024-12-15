import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryvel/ui/widgets/button/bottombutton.dart';
import 'package:tryvel/ui/widgets/form_field/place/address_search_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/holiday_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/image_uploder.dart';
import 'package:tryvel/ui/widgets/form_field/place/operating_hours_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/parking_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_description_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_name_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/category_dropdown_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_number_form_field.dart';

class PlaceUpdatePage extends StatefulWidget {
  final String placeId;

  const PlaceUpdatePage({Key? key, required this.placeId}) : super(key: key);

  @override
  _PlaceUpdatePageState createState() => _PlaceUpdatePageState();
}

class _PlaceUpdatePageState extends State<PlaceUpdatePage> {
  final storeNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressSearchController = TextEditingController();
  final holidayController = TextEditingController();
  final operatingHoursController = TextEditingController();
  final parkingController = TextEditingController();
  final storeNumberController = TextEditingController();
  final storeDescriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchPlaceData(); // Firestore에서 데이터 가져오기
  }

  @override
  void dispose() {
    storeNameController.dispose();
    categoryController.dispose();
    addressSearchController.dispose();
    holidayController.dispose();
    operatingHoursController.dispose();
    parkingController.dispose();
    storeNumberController.dispose();
    storeDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchPlaceData() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final docSnapshot =
          await firestore.collection('place').doc(widget.placeId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          setState(() {
            storeNameController.text = data['name'] ?? '';
            categoryController.text = data['category'] ?? '';
            addressSearchController.text = data['address'] ?? '';
            holidayController.text = data['holiday'] ?? '';
            operatingHoursController.text =
                '${data['open'] ?? ''} ~ ${data['close'] ?? ''}';
            parkingController.text = data['parking'] ?? '';
            storeNumberController.text = data['tel'] ?? '';
            storeDescriptionController.text = data['description'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching place data: $e');
    }
  }

  Future<void> _updatePlace() async {
    if (formKey.currentState!.validate()) {
      try {
        final firestore = FirebaseFirestore.instance;
        await firestore.collection('place').doc(widget.placeId).update({
          'name': storeNameController.text,
          'category': categoryController.text,
          'address': addressSearchController.text,
          'holiday': holidayController.text,
          'open': operatingHoursController.text.split('~')[0].trim(),
          'close': operatingHoursController.text.split('~')[1].trim(),
          'parking': parkingController.text,
          'tel': storeNumberController.text,
          'description': storeDescriptionController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('수정되었습니다!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('수정에 실패했습니다. 다시 시도해주세요.')),
        );
      }
    }
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
        title: const Text('플레이스 수정하기'),
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
                  Text(
                    '상호명',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreNameFormField(controller: storeNameController),
                  const SizedBox(height: 20),
                  Text(
                    '카테고리',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  CategoryDropdownFormField(controller: categoryController),
                  const SizedBox(height: 20),
                  Text(
                    '주소',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  AddressSearchFormField(
                    addressController: addressSearchController,
                    onCoordinatesSaved: (latitude, longitude) {
                      print('위도: $latitude, 경도: $longitude');
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '정기휴일',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  HolidayFormField(controller: holidayController),
                  const SizedBox(height: 20),
                  Text(
                    '운영시간',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  OperatingHoursFormField(controller: operatingHoursController),
                  const SizedBox(height: 20),
                  Text(
                    '주차가능여부',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  ParkingFormField(controller: parkingController),
                  const SizedBox(height: 20),
                  Text(
                    '매장 전화번호',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreNumberFormField(controller: storeNumberController),
                  const SizedBox(height: 20),
                  Text(
                    '매장 소개',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreDescriptionFormField(
                      controller: storeDescriptionController),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: Bottombutton(
        onPressed: _updatePlace, // 수정 버튼 클릭 시 업데이트 함수 호출
        label: '수정하기',
      ),
    );
  }
}
