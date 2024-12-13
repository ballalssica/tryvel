import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploder extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onPickImage;

  const ImageUploder({
    Key? key,
    required this.selectedImage,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(0),
        ),
        child: selectedImage == null
            ? const Center(
                child: Icon(Icons.add, color: Colors.white, size: 50),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.file(
                  selectedImage!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
