import 'package:flutter/material.dart';

class CampainManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Text('EditProfilePage'),
    );
  }
}
