import 'package:flutter/material.dart';

class ImageUploader extends StatelessWidget {
  final String? imageUrl; // 업로드된 이미지 URL
  final VoidCallback onImageSelected; // 이미지 선택 콜백

  const ImageUploader({
    Key? key,
    required this.imageUrl,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageSelected, // 터치 시 콜백 호출
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: imageUrl == null
              ? Colors.amber
              : Colors.transparent, // 이미지가 없으면 엠버색 배경
        ),
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover, // 업로드된 이미지 표시
              )
            : const Center(
                child:
                    Icon(Icons.add, size: 50, color: Colors.white), // 더하기 아이콘
              ),
      ),
    );
  }
}
