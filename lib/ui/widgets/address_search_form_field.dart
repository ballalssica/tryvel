import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressSearchFormField extends StatefulWidget {
  final TextEditingController addressController;
  final Function(String latitude, String longitude)? onCoordinatesSaved;

  const AddressSearchFormField({
    Key? key,
    required this.addressController,
    this.onCoordinatesSaved,
  }) : super(key: key);

  @override
  _AddressSearchFormFieldState createState() => _AddressSearchFormFieldState();
}

class _AddressSearchFormFieldState extends State<AddressSearchFormField> {
  String? latitude;
  String? longitude;

  // Kakao API로 주소 검색
  Future<void> openAddressSearch() async {
    // 새 창에서 주소 검색 열기 (임시 예제)
    final String? selectedAddress = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddressSearchPage(),
      ),
    );

    if (selectedAddress != null) {
      widget.addressController.text = selectedAddress;

      // 주소를 위도와 경도로 변환
      fetchCoordinates(selectedAddress);
    }
  }

  // Kakao API로 위도와 경도 가져오기
  Future<void> fetchCoordinates(String address) async {
    const String apiKey = 'YOUR_KAKAO_API_KEY'; // Kakao REST API 키
    final Uri url = Uri.parse(
      'https://dapi.kakao.com/v2/local/search/address.json?query=$address',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'KakaoAK $apiKey'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['documents'].isNotEmpty) {
          final location = data['documents'][0];
          setState(() {
            latitude = location['y'];
            longitude = location['x'];
          });

          // 콜백을 통해 위도/경도 전달
          if (widget.onCoordinatesSaved != null) {
            widget.onCoordinatesSaved!(latitude!, longitude!);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('위도: $latitude, 경도: $longitude')),
          );
        } else {
          _showError('주소를 찾을 수 없습니다.');
        }
      } else {
        _showError('요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      _showError('에러 발생: $e');
    }
  }

  // 에러 메시지 표시
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.addressController,
      decoration: InputDecoration(
        hintText: '주소를 검색하세요.',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          color: Colors.grey,
          onPressed: openAddressSearch,
        ),
      ),
      readOnly: true, // 검색으로만 입력하도록 설정
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '주소를 입력해주세요.';
        }
        return null;
      },
    );
  }
}

class AddressSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 주소 검색 API 연동 화면
    // 여기서 Kakao API 검색 결과를 사용자에게 보여주고 주소를 선택하게 합니다.
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소 검색'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 선택된 주소 예제 (실제 Kakao API 검색 결과 사용)
            Navigator.of(context).pop('서울특별시 강남구 테헤란로');
          },
          child: const Text('예제 주소 선택'),
        ),
      ),
    );
  }
}
