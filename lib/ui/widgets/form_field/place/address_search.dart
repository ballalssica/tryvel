import 'package:flutter/material.dart';

class AddressSearch extends StatelessWidget {
  final Function(String address) onAddressSelected;

  const AddressSearch({Key? key, required this.onAddressSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('AddressSearch');
  }
}
