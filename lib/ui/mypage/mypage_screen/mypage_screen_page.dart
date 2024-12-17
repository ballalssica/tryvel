import 'package:flutter/material.dart';
import 'package:tryvel/ui/place/place_add/place_add_page.dart';
import 'package:tryvel/ui/place/place_update/place_update_list.dart';

class MypageScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaceAddPage()),
                  );
                },
                child: const Text('플레이스 등록하기'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaceUpdateList()),
                  );
                },
                child: const Text('플레이스 수정하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
