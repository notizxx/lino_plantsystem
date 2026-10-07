import 'package:flutter/material.dart';
import 'loadingscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(
        //nextScreen: const HomePage(), // ganti dengan halaman utamamu
      ),
    );
  }
}