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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID de Usuario: $userId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateUserInfoPage(userId: userId),
                  ),
                );
              },
              child: const Text('Actualizar Información'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateUserInfoPage extends StatefulWidget {
  final String userId;

  const UpdateUserInfoPage({Key? key, required this.userId}) : super(key: key);

  @override
  UpdateUserInfoPageState createState() => UpdateUserInfoPageState();
}

class UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final firestore = FirebaseFirestore.instance; // Cambiado a firestore
    DocumentSnapshot userDoc = await firestore.collection('Usuarios').doc(widget.userId).get();
    
    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>;
      setState(() {
        _nombreController.text = data['nombre'] ?? '';
        _apellidoController.text = data['apellido'] ?? '';
        _ciController.text = data['ci'] ?? '';
        _fechaController.text = data['fecha_nacimiento'] ?? '';
        _sexoController.text = data['sexo'] ?? '';
        _emailController.text = data['email'] ?? '';
      });
    }
  }

  Future<void> _updateUserInfo() async {
    final firestore = FirebaseFirestore.instance; // Cambiado a firestore
    await firestore.collection('Usuarios').doc(widget.userId).update({
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'ci': _ciController.text,
      'fecha_nacimiento': _fechaController.text,
      'sexo': _sexoController.text,
      'email': _emailController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombres',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ciController,
              decoration: const InputDecoration(
                labelText: 'CI',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _fechaController,
              decoration: const InputDecoration(
                labelText: 'Fecha de Nacimiento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _sexoController,
              decoration: const InputDecoration(
                labelText: 'Sexo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _updateUserInfo,
              child: const Text('Actualizar Información'),
            ),
          ],
        ),
      ),
    );
  }
}
