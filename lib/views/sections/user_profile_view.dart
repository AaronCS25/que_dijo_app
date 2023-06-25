import 'package:flutter/material.dart';
import 'package:que_dijo_app/services/auth_service.dart';
import 'package:que_dijo_app/views/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Cerrar Sesión'),
          onPressed: () {
            _showLogoutConfirmationDialog(
                context); // Muestra la ventana de confirmación de cierre de sesión
          },
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Estás seguro de que deseas cerrar la sesión?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cierra la ventana de confirmación
              },
            ),
            TextButton(
              child: Text('Cerrar Sesión'),
              onPressed: () {
                _logout(context); // Cierra la sesión
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    await Auth.deleteToken();
    await Auth.deleteUserId();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginView()), // Crea una instancia de SignUpView y la muestra
    );
  }
}
