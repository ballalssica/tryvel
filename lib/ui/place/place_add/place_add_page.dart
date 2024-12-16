import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 사용
import 'package:tryvel/ui/place/place_add/placeAddViewModelProvider.dart';
import 'package:tryvel/ui/widgets/button/bottombutton.dart';
import 'package:tryvel/ui/widgets/form_field/place/address_search_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/holiday_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/image_uploader.dart';
import 'package:tryvel/ui/widgets/form_field/place/operating_hours_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/parking_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_description_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_name_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/category_dropdown_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_number_form_field.dart';

class PlaceAddPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelManager = ref.watch(placeAddViewModelProvider.notifier);
    final state = ref.watch(placeAddViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이스 등록하기'),
      ),
      body: ListView(
        children: [
          // 이미지 업로드 위젯
          ImageUploader(
            imageUrl: state.imageUrl, // 업로드된 URL로 이미지 표시
            onImageSelected: () async {
              await viewModelManager.pickImage(); // 이미지 선택 및 업로드 처리
            },
          ),
          const SizedBox(height: 20),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '상호명',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreNameFormField(
                    controller: TextEditingController(
                      text: state.storeName,
                    ),
                    onChanged: viewModelManager.updateStoreName,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '카테고리',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  CategoryDropdownFormField(
                    controller: TextEditingController(
                      text: state.category,
                    ),
                    onChanged: viewModelManager.updateCategory,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '주소',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  AddressSearchFormField(
                    addressController: TextEditingController(
                      text: state.address,
                    ),
                    onCoordinatesSaved: (latitude, longitude) {
                      viewModelManager.updateAddress('$latitude, $longitude');
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '정기휴일',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  HolidayFormField(
                    controller: TextEditingController(
                      text: state.holiday,
                    ),
                    onChanged: viewModelManager.updateHoliday,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '운영시간',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  OperatingHoursFormField(
                    controller: TextEditingController(
                      text: state.operatingHours,
                    ),
                    onChanged: viewModelManager.updateOperatingHours,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '주차가능여부',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  ParkingFormField(
                    controller: TextEditingController(
                      text: state.parking,
                    ),
                    onChanged: viewModelManager.updateParking,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '매장 전화번호',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreNumberFormField(
                    controller: TextEditingController(
                      text: state.storeNumber,
                    ),
                    onChanged: viewModelManager.updateStoreNumber,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '매장 소개',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreDescriptionFormField(
                    controller: TextEditingController(
                      text: state.description,
                    ),
                    onChanged: viewModelManager.updateDescription,
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottombutton(
        onPressed: () async {
          final success = await viewModelManager.savePlace();
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('등록되었습니다!')),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('등록에 실패했습니다. 다시 시도해주세요.')),
            );
          }
        },
        label: '등록하기',
      ),
    );
  }
}
