import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Usuario'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Usuarios').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Usuario no encontrado.'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text('Nombre: ${data['nombre'] ?? 'N/A'}'),
                Text('Apellido: ${data['apellido'] ?? 'N/A'}'),
                Text('CI: ${data['ci'] ?? 'N/A'}'),
                Text('Fecha de Nacimiento: ${data['fecha_nacimiento'] ?? 'N/A'}'),
                Text('Sexo: ${data['sexo'] ?? 'N/A'}'),
                Text('Correo Electrónico: ${data['email'] ?? 'N/A'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
