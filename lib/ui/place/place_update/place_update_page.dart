import 'package:flutter/material.dart';
import 'package:tryvel/ui/widgets/form_field/place/image_uploader.dart';
import 'place_update_view_model.dart';

class PlaceUpdatePage extends StatelessWidget {
  final String placeId;
  final viewModel = PlaceUpdateViewModel();

  PlaceUpdatePage({Key? key, required this.placeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이스 수정하기'),
      ),
      body: FutureBuilder(
        future: viewModel.fetchPlaceData(placeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              // 이미지 업로드
              ImageUploader(
                imageUrl: viewModel.state.imageUrl,
                onImageSelected: () async {
                  await viewModel.pickImage();
                },
              ),
              const SizedBox(height: 20),
              Form(
                key: viewModel.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('상호명',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.storeNameController,
                      ),
                      const SizedBox(height: 20),
                      const Text('카테고리',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.categoryController,
                      ),
                      const SizedBox(height: 20),
                      const Text('주소',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.addressController,
                      ),
                      const SizedBox(height: 20),
                      const Text('정기휴일',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.holidayController,
                      ),
                      const SizedBox(height: 20),
                      const Text('운영시간',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.operatingHoursController,
                      ),
                      const SizedBox(height: 20),
                      const Text('주차 가능 여부',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.parkingController,
                      ),
                      const SizedBox(height: 20),
                      const Text('매장 전화번호',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.storeNumberController,
                      ),
                      const SizedBox(height: 20),
                      const Text('매장 소개',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: viewModel.storeDescriptionController,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          final success = await viewModel.updatePlace(placeId);
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('수정되었습니다!')),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('수정에 실패했습니다. 다시 시도해주세요.')),
            );
          }
        },
        child: const Text('수정하기'),
      ),
    );
  }
}
