import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tryvel/ui/widgets/stroe_name_text_form_field.dart';
import 'package:tryvel/ui/widgets/business_name_text_form_field.dart';
import 'package:tryvel/ui/widgets/category_dropdown_form_field.dart';

class PlaceAddPage extends StatefulWidget {
  @override
  _PlaceAddPageState createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  final storeNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final categoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    storeNameController.dispose();
    businessNameController.dispose();
    categoryController.dispose();
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
          // 이미지 선택 영역 (가로 전체 사용)
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(0),
              ),
              child: _selectedImage == null
                  ? const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 50),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          // 폼 요소들 (패딩 적용)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    // 상호명 필드
                    Row(
                      children: [
                        Text(
                          '상호명',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          ' *',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    StroeNameTextFormField(controller: storeNameController),
                    const SizedBox(height: 20),

                    // 사업자명 필드
                    Text(
                      '사업자명',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    BusinessNameTextFormField(
                        controller: businessNameController),
                    const SizedBox(height: 20),

                    // 카테고리 필드
                    Row(
                      children: [
                        Text(
                          '카테고리',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          ' *',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    CategoryDropdownFormField(controller: categoryController),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0), // 가로 전체 사용
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('등록되었습니다!')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60), // 버튼 높이 설정
          ),
          child: const Text('등록하기'),
        ),
      ),
    );
  }
}
