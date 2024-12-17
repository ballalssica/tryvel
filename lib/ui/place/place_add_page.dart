import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryvel/ui/place/place_form.dart';
import 'package:tryvel/ui/place/place_view_model.dart';

class PlaceAddPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceViewModel(),
      child: Scaffold(
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
                    Navigator.pop(context);
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
