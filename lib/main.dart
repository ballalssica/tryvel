import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tryvel/ui/home/home_page.dart';
import 'package:tryvel/ui/place_add/place_add_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        highlightColor: Colors.amber,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(WidgetState.disabled)) {
                  return const Color(0xFFD6D6D6); // 비활성화된 버튼 텍스트 색상
                }
                return Colors.white; // 기본 활성화된 버튼 텍스트 색상
              },
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(WidgetState.disabled)) {
                  return const Color(0xFF4A4A4A); // 비활성화된 버튼 배경색
                }
                return Colors.amber; // 기본 활성화된 버튼 배경색
              },
            ),
            minimumSize: WidgetStateProperty.all(
              const Size.fromHeight(60),
            ),
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),

        //INPUT BOX
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey, // 비활성화 상태 테두리 색상
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber, // 포커스 상태 테두리 색상
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFFFCDD2), // 에러 상태 테두리 색상
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber, // 포커스된 에러 상태 테두리 색상
              width: 2,
            ),
          ),
          errorStyle: const TextStyle(
            color: Color(0xFFFFA000), // 에러 메시지 색상
            fontSize: 12, // 에러 메시지 글자 크기
          ),
        ),
      ),
      home: PlaceAddPage(),
    );
  }
}
