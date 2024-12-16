import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 사용
import 'package:tryvel/ui/place/place_update/place_update_view_model.dart';
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

class PlaceUpdatePage extends ConsumerWidget {
  final String placeId;

  const PlaceUpdatePage({Key? key, required this.placeId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(placeUpdateViewModelProvider(placeId).notifier);
    final state = ref.watch(placeUpdateViewModelProvider(placeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('플레이스 수정하기'),
      ),
      body: ListView(
        children: [
          ImageUploader(
            imageUrl: state.imageUrl, // 업로드된 URL로 이미지 표시
            onImageSelected: () async {
              await viewModel.pickImage(); // 이미지 선택 및 업로드 처리
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
                  const Text(
                    '상호명',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreNameFormField(
                    controller: viewModel.storeNameController,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '카테고리',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  CategoryDropdownFormField(
                    controller: viewModel.categoryController,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '주소',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  AddressSearchFormField(
                    addressController: viewModel.addressSearchController,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '정기휴일',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  HolidayFormField(controller: viewModel.holidayController),
                  const SizedBox(height: 20),
                  const Text(
                    '운영시간',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  OperatingHoursFormField(
                    controller: viewModel.operatingHoursController,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '주차가능여부',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  ParkingFormField(controller: viewModel.parkingController),
                  const SizedBox(height: 20),
                  const Text(
                    '매장 전화번호',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreNumberFormField(
                      controller: viewModel.storeNumberController),
                  const SizedBox(height: 20),
                  const Text(
                    '매장 소개',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  StoreDescriptionFormField(
                    controller: viewModel.storeDescriptionController,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: Bottombutton(
        onPressed: viewModel.updatePlace, // 수정 버튼 클릭 시 업데이트 함수 호출
        label: '수정하기',
      ),
    );
  }
}
