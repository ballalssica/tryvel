import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tryvel/ui/place_add/widgets/registration_button%20.dart';
import 'package:tryvel/ui/widgets/address_search_form_field.dart';
import 'package:tryvel/ui/widgets/image_uploder.dart';
import 'package:tryvel/ui/widgets/stroe_name_text_form_field.dart';
import 'package:tryvel/ui/widgets/category_dropdown_form_field.dart';

class PlaceAddPage extends StatefulWidget {
  @override
  _PlaceAddPageState createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  final storeNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final categoryController = TextEditingController();
  final addressController = TextEditingController(); // 주소 컨트롤러 추가
  final formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    storeNameController.dispose();
    businessNameController.dispose();
    categoryController.dispose();
    addressController.dispose(); // 주소 컨트롤러 dispose
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
                      children: [
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
                    StroeNameTextFormField(controller: storeNameController),
                    const SizedBox(height: 20),
                    Row(
                      children: [
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
                      children: [
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
                      addressController: addressController, // 추가
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
