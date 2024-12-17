import 'package:flutter/material.dart';
import 'package:tryvel/ui/place/place_view_model.dart';
import 'package:tryvel/ui/place/widgets/address_detail_form_field.dart';
import 'package:tryvel/ui/place/widgets/address_search_form_field.dart';
import 'package:tryvel/ui/place/widgets/category_dropdown_form_field.dart';
import 'package:tryvel/ui/place/widgets/holiday_form_field.dart';
import 'package:tryvel/ui/place/widgets/image_uploader.dart';
import 'package:tryvel/ui/place/widgets/operating_hours_form_field.dart';
import 'package:tryvel/ui/place/widgets/parking_form_field.dart';
import 'package:tryvel/ui/place/widgets/store_description_form_field.dart';
import 'package:tryvel/ui/place/widgets/store_name_form_field.dart';
import 'package:tryvel/ui/place/widgets/store_number_form_field.dart';
import 'package:tryvel/ui/widgets/button/bottombutton.dart';

class PlaceForm extends StatelessWidget {
  final PlaceViewModel viewModel; // PlaceViewModel 타입으로 변경
  final GlobalKey<FormState> formKey;
  final String buttonLabel;
  final Function() onSubmit;

  const PlaceForm({
    Key? key,
    required this.viewModel,
    required this.formKey,
    required this.buttonLabel,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
            key: formKey,
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
                      viewModel.updateCoordinates(
                        double.parse(latitude),
                        double.parse(longitude),
                      );
                      viewModel.updateAddress(address);
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
                    validator: (String? value) {},
                  ),
                  const SizedBox(height: 20),
                  const Text('매장 소개',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  StoreDescriptionFormField(
                    controller: viewModel.storeDescriptionController,
                    onChanged: viewModel.updateDescription,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottombutton(
        onPressed: onSubmit,
        label: buttonLabel,
      ),
    );
  }
}
