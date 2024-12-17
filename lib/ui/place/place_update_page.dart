import 'package:flutter/material.dart';
import 'package:tryvel/ui/place/place_form.dart';
import 'package:tryvel/ui/place/place_view_model.dart';

class PlaceUpdatePage extends StatelessWidget {
  final String placeId;
  final formKey = GlobalKey<FormState>();

  PlaceUpdatePage({required this.placeId});

  @override
  Widget build(BuildContext context) {
    final viewModel = PlaceViewModel();

    return Scaffold(
      appBar: AppBar(title: const Text('플레이스 수정하기')),
      body: FutureBuilder(
        future: viewModel.fetchPlaceData(placeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return PlaceForm(
            viewModel: viewModel,
            formKey: formKey,
            buttonLabel: '수정하기',
            onSubmit: () async {
              if (formKey.currentState!.validate()) {
                final success = await viewModel.updatePlace(placeId);
                if (success) {
                  Navigator.pop(context);
                }
              }
            },
          );
        },
      ),
    );
  }
}
