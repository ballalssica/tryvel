import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:tryvel/core/utils/validator_util.dart'; // ValidatorUtil 가져오기

class AddressSearchFormField extends StatefulWidget {
  final TextEditingController addressController;
  final TextEditingController coordinatesController; // 위도, 경도 표현용 컨트롤러 추가
  final String? Function(String?)? validatorAddress; // 유효성 검사 함수
  final Function(String latitude, String longitude)? onCoordinatesSaved;

  const AddressSearchFormField({
    Key? key,
    required this.addressController,
    required this.coordinatesController,
    this.validatorAddress,
    this.onCoordinatesSaved,
  }) : super(key: key);

  @override
  _AddressSearchFormFieldState createState() => _AddressSearchFormFieldState();
}

class _AddressSearchFormFieldState extends State<AddressSearchFormField> {
  void _searchAddress(BuildContext context) async {
    // 주소 검색 페이지 열기
    KopoModel? model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    // 주소 검색 결과 처리
    if (model != null) {
      final address = model.address ?? '';
      widget.addressController.value = TextEditingValue(
        text: address,
      );

      // 예제 위도와 경도 (API 연동 시 실제 값으로 교체)
      final latitude = "37.5665"; // 예시 위도
      final longitude = "126.9780"; // 예시 경도

      // 위도와 경도를 coordinatesController에 추가
      widget.coordinatesController.value = TextEditingValue(
        text: "위도: $latitude, 경도: $longitude",
      );

      // 콜백 함수 호출
      if (widget.onCoordinatesSaved != null) {
        widget.onCoordinatesSaved!(latitude, longitude);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _searchAddress(context),
          child: AbsorbPointer(
            // TextField를 읽기 전용으로 만듦
            child: TextFormField(
              controller: widget.addressController,
              decoration: InputDecoration(
                hintText: '주소를 검색해주세요.',
                border: const OutlineInputBorder(),
                suffixIcon: widget.addressController.text.isEmpty
                    ? const Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                    : null, // 주소가 비어있을 때만 돋보기 아이콘 표시
              ),
              validator:
                  widget.validatorAddress ?? ValidatorUtil.validatoraddress,
            ),
          ),
        ),
      ],
    );
  }
}
