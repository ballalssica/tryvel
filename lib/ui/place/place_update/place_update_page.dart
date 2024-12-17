import 'package:flutter/material.dart';
import 'package:tryvel/ui/place/place_form.dart';
import 'package:tryvel/ui/place/place_view_model.dart';
import 'package:tryvel/data/model/place.dart';

class PlaceUpdatePage extends StatefulWidget {
  final Place place;

  const PlaceUpdatePage({Key? key, required this.place}) : super(key: key);

  @override
  _PlaceUpdatePageState createState() => _PlaceUpdatePageState();
}

class _PlaceUpdatePageState extends State<PlaceUpdatePage> {
  final formKey = GlobalKey<FormState>();
  late PlaceViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = PlaceViewModel();
    viewModel.setPlaceData(widget.place); // 기존 데이터 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('플레이스 수정하기')),
      body: PlaceForm(
        viewModel: viewModel,
        formKey: formKey,
        buttonLabel: '수정하기',
        onSubmit: () async {
          if (formKey.currentState!.validate()) {
            final success = await viewModel.updatePlace(widget.place.id);
            if (success) {
              Navigator.pop(context); // 성공 시 이전 화면으로 돌아가기
            }
          }
        },
      ),
    );
  }
}
