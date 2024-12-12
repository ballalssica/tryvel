import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryvel/ui/widgets/business_name_text_form_field.dart';
import 'package:tryvel/ui/widgets/category_dropdown_form_field.dart';
import 'dart:io';

import 'package:tryvel/ui/widgets/stroe_name_text_form_field.dart';

class PlaceAddPage extends StatefulWidget {
  @override
  _PlaceAddPageState createState() => _PlaceAddPageState();
}

class _PlaceAddPageState extends State<PlaceAddPage> {
  final storeNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // controller 사용시 dispose 필수 구현
  @override
  void dispose() {
    storeNameController.dispose();
    businessNameController.dispose();
    super.dispose();
  }

  File? _selectedImage; // 선택한 이미지를 저장할 변수
  final ImagePicker _picker = ImagePicker();

  // 이미지 선택 함수
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('플레이스 등록하기'),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              // 이미지 선택 영역
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: _selectedImage == null
                      ? Center(
                          child: Icon(Icons.add, color: Colors.white, size: 50),
                        )
                      : ClipRRect(
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 매장명 입력 필드
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
                          '*',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    StroeNameTextFormField(controller: storeNameController),
                    SizedBox(height: 20),
                    Text(
                      '사업자명',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5),
                    BusinessNameTextFormField(
                        controller: businessNameController),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(0), // 버튼 여백 추가
          child: ElevatedButton(
            onPressed: () {
              formKey.currentState?.validate();
            },
            child: const Text('등록하기'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(60), // 버튼의 높이 설정
            ),
          ),
        ),
      ),
    );
  }
}
