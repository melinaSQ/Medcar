import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_page.dart'; // Asegúrate de importar tu página de perfil

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Ver Información de la cuenta'),
            onTap: () async {
              // Obtener el ID del usuario actual
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(userId: user.uid),
                  ),
                );
              } else {
                // Manejo de error si no hay usuario autenticado
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No estás autenticado.'),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Actualizar Número'),
            onTap: () {
              // Navegar a la página de actualización de número
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historial de Solicitudes'),
            onTap: () {
              // Navegar a la página del historial de solicitudes
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Soporte'),
            onTap: () {
              // Navegar a la página de soporte
            },
          ),
        ],
      ),
    );
  }
}
