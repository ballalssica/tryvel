import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tryvel/ui/place_add/widgets/registration_button%20.dart';
import 'package:tryvel/ui/widgets/form_field/place/address_search_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/holiday_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/image_uploder.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_name_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/category_dropdown_form_field.dart';

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
      body: Column(
        children: [
          // 이미지 선택 영역
          ImageUploder(
            selectedImage: _selectedImage,
            onPickImage: _pickImage,
          ),
          const SizedBox(height: 16),
          // 폼 요소들
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: ListView(
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
                      addressController: addressSearchController, // 필수 매개변수 추가
                      onCoordinatesSaved: (latitude, longitude) {
                        // 위도와 경도를 처리하는 로직 추가
                        print('위도: $latitude, 경도: $longitude');
                      },
                    ),
                    const SizedBox(height: 20),
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
                    HolidayFormField(
                      controller: holidayController,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
