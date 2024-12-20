import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryvel/ui/place/place_form.dart';
import 'package:tryvel/ui/place/place_view_model.dart';
import 'package:tryvel/ui/widgets/popup/temporary_popup.dart';

class PlaceAddPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('플레이스 등록하기')),
        body: Consumer<PlaceViewModel>(
          builder: (context, viewModel, _) {
            return PlaceForm(
              viewModel: viewModel,
              formKey: formKey,
              buttonLabel: '등록하기',
              onSubmit: () async {
                if (formKey.currentState!.validate()) {
                  final success = await viewModel.savePlace();
                  if (success) {
                    // TemporaryPopup 호출
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const TemporaryPopup(
                          text: '등록되었습니다.', // 팝업에 표시할 텍스트
                        );
                      },
                    );

                    // 1초 후 팝업 닫기 및 이전 페이지로 이동
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context); // 팝업 닫기
                      Navigator.pop(context, true); // 이전 페이지로 데이터 추가 성공 전달
                    });
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
