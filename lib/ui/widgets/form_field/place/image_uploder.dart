import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploader extends StatelessWidget {
  final XFile? selectedImage;
  final Function(XFile) onImageSelected;

  const ImageUploader({
    Key? key,
    this.selectedImage,
    required this.onImageSelected,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      final XFile? pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        onImageSelected(pickedFile);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.amber,
          image: selectedImage != null
              ? DecorationImage(
                  image: FileImage(File(selectedImage!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: selectedImage == null
            ? const Center(
                child: Icon(Icons.add, color: Colors.white, size: 50),
              )
            : null,
      ),
    );
  }
}
