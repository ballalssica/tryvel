import 'package:flutter/material.dart';

class CategoryDropdownFormField extends StatefulWidget {
  @override
  _DataSelectionPageState createState() => _DataSelectionPageState();
}

class _DataSelectionPageState extends State<CategoryDropdownFormField> {
  // 선택 가능한 데이터 목록
  final List<String> categoryList = [
    '숙소',
    '맛집',
    '카페',
    '레저',
    '기타',
  ];

  // 선택된 값을 저장할 변수
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '데이터를 선택하세요',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                hintText: 'Select an option',
              ),
              items: categoryList.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value; // 선택된 값 업데이트
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
