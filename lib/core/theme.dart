import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF4A4A4A),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.amber, // 뒤로가기 아이콘 색상을 앰버로 설정
        ),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      highlightColor: Colors.amber,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return const Color(0xFFD6D6D6);
              }
              return Colors.white;
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return const Color(0xFF4A4A4A);
              }
              return Colors.amber;
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
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFCDD2),
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: Color(0xFFFFA000),
          fontSize: 12,
        ),
      ),
    );
  }
}
