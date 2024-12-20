import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:dio/dio.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class AddressSearchFormField extends StatefulWidget {
  final TextEditingController addressController;
  final TextEditingController coordinatesController; // 위도, 경도 표현용 컨트롤러 추가
  final String? Function(String?)? validatorAddress; // 유효성 검사 함수
  final Function(String address, String latitude, String longitude)?
      onCoordinatesSaved; // address 추가

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
  final String kakaoApiKey =
      "54e58cf81fee729b896e5b2a4d9ae211"; // 카카오 REST API 키

  Future<void> _searchAddress(BuildContext context) async {
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

      // 위도와 경도를 가져오는 함수 호출
      await _getCoordinates(address);
    }
  }

  Future<void> _getCoordinates(String address) async {
    final String url =
        'https://dapi.kakao.com/v2/local/search/address.json?query=${Uri.encodeComponent(address)}';

    // 헤더 구성
    final headers = {'Authorization': 'KakaoAK $kakaoApiKey'};
    print('Request Headers: $headers'); // 헤더 확인용 출력

    try {
      // dio 패키지를 사용하여 HTTP GET 요청
      final response = await Dio().get(
        url,
        options: Options(headers: headers),
      );

      print('Response Status Code: ${response.statusCode}'); // 응답 상태 코드 출력
      print('Response Data: ${response.data}'); // 응답 데이터 출력

      // Response에서 위도(latitude)와 경도(longitude) 추출
      if (response.data['documents'] != null &&
          response.data['documents'].isNotEmpty) {
        final latitude = response.data['documents'][0]['y'];
        final longitude = response.data['documents'][0]['x'];

        // coordinatesController에 위도와 경도를 저장
        widget.coordinatesController.value = TextEditingValue(
          text: "위도: $latitude, 경도: $longitude",
        );

        // 위/경도 확인인
        print('Address: $address, 위도: $latitude, 경도: $longitude');

        // 부모 위젯에 콜백 호출
        if (widget.onCoordinatesSaved != null) {
          print(
              'AddressSearchFormField에서 보낸 데이터: Address: $address, Latitude: $latitude, Longitude: $longitude');
          widget.onCoordinatesSaved!(address, latitude, longitude);
        }
      } else {
        // 위도와 경도를 찾을 수 없는 경우
        widget.coordinatesController.value = TextEditingValue(
          text: "위도와 경도를 찾을 수 없습니다.",
        );
        print('No documents found in the response.'); // 응답에 문서 없음 로그
      }
    } catch (e) {
      print('Error fetching coordinates: $e'); // 에러 로그 출력
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
