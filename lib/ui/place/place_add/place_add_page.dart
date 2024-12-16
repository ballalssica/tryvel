import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'place_add_view_model.dart';
import 'package:tryvel/ui/widgets/button/bottombutton.dart';
import 'package:tryvel/ui/widgets/form_field/place/address_detail_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/address_search_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/holiday_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/image_uploader.dart';
import 'package:tryvel/ui/widgets/form_field/place/operating_hours_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/parking_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_description_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_name_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/category_dropdown_form_field.dart';
import 'package:tryvel/ui/widgets/form_field/place/store_number_form_field.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class PlaceAddPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceAddViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('플레이스 등록하기'),
        ),
        body: Consumer<PlaceAddViewModel>(
          builder: (context, viewModel, _) {
            return ListView(
              children: [
                // 이미지 업로드 위젯
                ImageUploader(
                  imageUrl: viewModel.state.imageUrl,
                  onImageSelected: () async {
                    await viewModel.pickImage();
                  },
                ),
                const SizedBox(height: 20),
                Form(
                  key: formKey, // Form 상태를 추적하기 위한 key
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('상호명',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        StoreNameFormField(
                          controller: viewModel.storeNameController,
                          onChanged: viewModel.updateStoreName,
                        ),
                        const SizedBox(height: 20),
                        const Text('카테고리',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        CategoryDropdownFormField(
                          controller: viewModel.categoryController,
                          onChanged: viewModel.updateCategory,
                        ),
                        const SizedBox(height: 20),
                        const Text('주소',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        AddressSearchFormField(
                          addressController: viewModel.addressController,
                          coordinatesController: TextEditingController(),
                          onCoordinatesSaved: (address, latitude, longitude) {
                            print(
                                'PlaceAddPage에서 받은 콜백 데이터: Address: $address, Latitude: $latitude, Longitude: $longitude');
                            viewModel.updateCoordinates(
                              double.parse(latitude),
                              double.parse(longitude),
                            );
                            viewModel.updateAddress(
                                address); // Address를 ViewModel에 업데이트
                          },
                        ),
                        const SizedBox(height: 5),
                        AddressDetailFormField(
                          controller: viewModel.addressDetailController,
                          onChanged: viewModel.updateAddressDetail,
                        ),
                        const SizedBox(height: 20),
                        const Text('정기휴일',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        HolidayFormField(
                          controller: viewModel.holidayController,
                          onChanged: viewModel.updateHoliday,
                        ),
                        const SizedBox(height: 20),
                        const Text('운영시간',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        OperatingHoursFormField(
                          controller: viewModel.operatingHoursController,
                          onChanged: viewModel.updateOperatingHours,
                        ),
                        const SizedBox(height: 20),
                        const Text('주차 가능 여부',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        ParkingFormField(
                          controller: viewModel.parkingController,
                          onChanged: viewModel.updateParking,
                        ),
                        const SizedBox(height: 20),
                        const Text('매장 전화번호',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        StoreNumberFormField(
                          controller: viewModel.storeNumberController,
                          onChanged: viewModel.updateStoreNumber,
                          validator: ValidatorUtil.validatorstoreNumber,
                        ),
                        const SizedBox(height: 20),
                        const Text('매장 소개',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 5),
                        StoreDescriptionFormField(
                          controller: viewModel.storeDescriptionController,
                          onChanged: viewModel.updateDescription,
                        ),
                        const SizedBox(height: 200),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<PlaceAddViewModel>(
          builder: (context, viewModel, _) {
            return Bottombutton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final success = await viewModel.savePlace();
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
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('등록 승인을 위해 모든 정보가 필요합니다.')),
                  );
                }
              },
              label: '등록하기',
            );
          },
        ),
      ),
    );
  }
}
