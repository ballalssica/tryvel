import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tryvel/ui/user/business/business_user_benefits_page.dart';
import 'package:tryvel/ui/user/influencer/edit_profile_page.dart';

class BusinessNameCard extends StatefulWidget {
  @override
  _UserNameCardState createState() => _UserNameCardState();
}

class _UserNameCardState extends State<BusinessNameCard> {
  File? _profileImage; // 프로필 이미지 상태 관리

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF4A4A4A), // 배경색 그레이
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 등급 노출
          const Text(
            'DIAMIND',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 5), // 간격

          // 닉네임 노출
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50, // 투명 배경 높이 50
                      color: Colors.transparent, // 투명 배경
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '낭만마녀',
                            style: TextStyle(
                              decoration: TextDecoration.underline, // 밑줄
                              decorationColor: Colors.white, // 밑줄 색상 하얀색
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // 텍스트 색상
                            ),
                          ),
                          const Text(
                            '님,',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    '안녕하세요!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ssicanara@naver.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD6D6D6),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // 프로필 사진
              Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: const Color(0xFFD6D6D6),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Color(0xFF4A4A4A),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          color: const Color(0xFF4A4A4A),
                        ),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFF4A4A4A),
                          child: Icon(
                            Icons.camera_alt,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20), // 간격

          // 반투명 흰색 컨테이너
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessUserBenefitsPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3), // 반투명 흰색 배경
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '트라이블 사용이 처음이신가요?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '혜택보기',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // 텍스트 색상
                      decoration: TextDecoration.underline, // 밑줄
                      decorationColor: Colors.white, // 밑줄 색상 (화이트)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
