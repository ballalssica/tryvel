import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tryvel/data/model/place.dart';
import 'package:tryvel/data/repository/place_repository.dart'; // PlaceRepository 가져오기
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

class PlaceAddPage extends StatefulWidget {
  @override
  _PlaceAddPageState createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  final storeNameController = TextEditingController();
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
  final PlaceRepository _placeRepository =
      PlaceRepository(); // PlaceRepository 인스턴스

  @override
  void dispose() {
    storeNameController.dispose();
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

  Future<void> _savePlace() async {
    if (formKey.currentState!.validate()) {
      try {
        // 운영시간 파싱 및 검증
        final operatingHours = operatingHoursController.text.split('~');
        final openTime =
            operatingHours.isNotEmpty ? operatingHours[0].trim() : ''; // 시작 시간
        final closeTime =
            operatingHours.length > 1 ? operatingHours[1].trim() : ''; // 종료 시간

        // Firestore에 데이터 저장
        final success = await _placeRepository.insert(
          name: storeNameController.text,
          category: categoryController.text,
          address: addressSearchController.text,
          holiday: holidayController.text,
          open: openTime, // 문자열로 저장
          close: closeTime, // 문자열로 저장
          tel: storeNumbercontroller.text,
          description: storeDescrptionController.text,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('등록되었습니다!')),
          );
          Navigator.pop(context); // 저장 후 페이지 종료
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('등록에 실패했습니다. 다시 시도해주세요.')),
          );
        }
      } catch (e) {
        // 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('운영시간 입력 형식이 잘못되었습니다.')),
        );
      }
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
                  Text('상호명',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  StoreNameFormField(controller: storeNameController),
                  const SizedBox(height: 20),
                  Text('카테고리',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  CategoryDropdownFormField(controller: categoryController),
                  const SizedBox(height: 20),
                  Text('주소',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  AddressSearchFormField(
                    addressController: addressSearchController,
                    onCoordinatesSaved: (latitude, longitude) {
                      print('위도: $latitude, 경도: $longitude');
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('정기휴일',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  HolidayFormField(controller: holidayController),
                  const SizedBox(height: 20),
                  Text('운영시간',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  OperatingHoursFormField(controller: operatingHoursController),
                  const SizedBox(height: 20),
                  Text('주차가능여부',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  ParkingFormField(controller: parkingController),
                  const SizedBox(height: 20),
                  Text('매장 전화번호',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  StoreNumberFormField(controller: storeNumbercontroller),
                  const SizedBox(height: 20),
                  Text('매장 소개',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
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
      bottomNavigationBar: Bottombutton(
        onPressed: _savePlace, // 저장 버튼 클릭 시 _savePlace 호출
        label: '등록하기',
      ),
    );
  }
}
