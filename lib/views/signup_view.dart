import 'package:flutter/material.dart';
import 'package:que_dijo_app/apis/signup_api_service.dart';
import 'package:que_dijo_app/models/signup_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _correoController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _contrasenaController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                SignUpApiService signUpApiService = SignUpApiService();
                SignUpRequestModel signUpRequestModel = SignUpRequestModel(
                    nombre: _nombreController.text,
                    correo: _correoController.text,
                    contrasena: _contrasenaController.text);

                try {
                  print('controler: ${_correoController.text}');
                  print('correo: ${signUpRequestModel.correo}');
                  print('contrasena: ${signUpRequestModel.contrasena}');
                  SignUpResponseModel response =
                      await signUpApiService.signup(signUpRequestModel);

                  if (response.statusCode == 200) {
                    //TODO: Hace algo
                  } else {
                    // TODO: Notificar al usuario el error.
                  }

                  //TODO: mostrar notificación de exito

                  Navigator.pushReplacementNamed(context, '/');
                } catch (error) {
                  //TODO: mostrar una notificación de error.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error en el registro: $error'),
                    ),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
