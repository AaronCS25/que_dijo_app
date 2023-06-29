import 'package:flutter/material.dart';
import 'package:que_dijo_app/config/themes/app_theme.dart';
import 'package:que_dijo_app/views/home_view.dart';
import 'package:que_dijo_app/views/login_view.dart';
import 'package:que_dijo_app/views/signup_view.dart';
import 'package:que_dijo_app/views/upload_files_view.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';

Future<void> _configureAmplify() async {
  try {
    print("Configuracion amplify");
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([auth, storage]);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

void main() async {
  runApp(const MainApp());
  await _configureAmplify();
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
