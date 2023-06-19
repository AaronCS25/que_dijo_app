import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/login_api_service.dart';
import 'package:que_dijo_app/models/login_model.dart';
import 'package:que_dijo_app/services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginApiService loginApiService = LoginApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () async {
                  //print('Here!');
                  LoginRequestModel loginRequestModel = LoginRequestModel(
                      correo: mailController.text,
                      contrasena: passwordController.text);

                  try {
                    LoginResponseModel loginResponseModel =
                        await loginApiService.login(loginRequestModel);

                    if (loginResponseModel.statusCode == 200) {
                      await Auth.saveToken(loginResponseModel.token);
                      await Auth.saveUserId(
                          loginResponseModel.userId.toString());

                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // TODO: Notificar al usuario el error.
                    }
                  } catch (error) {
                    //print('Error: $error');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $error'),
                      ),
                    );
                  }
                },
                child: const Text('Login')),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {},
              child: const Text('¿No recuerdas tú contraseña?'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Sign up')),
          ],
        ),
      ),
    );
  }
}
