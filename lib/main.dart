import 'package:flutter/material.dart';
import 'package:que_dijo_app/config/themes/app_theme.dart';
import 'package:que_dijo_app/views/home_view.dart';
import 'package:que_dijo_app/views/login_view.dart';
import 'package:que_dijo_app/views/signup_view.dart';
import 'package:que_dijo_app/views/upload_files_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuéDijo?',
      theme: AppTheme(selectedColor: 0).theme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/signup': (context) => const SignUpView(),
        '/home': (context) => const HomeView(),
        '/upload': (context) => const UploadFilesView()
      },
    );
  }
}
