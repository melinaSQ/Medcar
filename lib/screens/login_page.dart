import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _login() async {
    String phone = _phoneController.text.trim();
    String code = _codeController.text.trim();

    if (phone.isNotEmpty && code.isNotEmpty) {
      // Verificar si el número de celular existe en la base de datos
      QuerySnapshot snapshot = await _firestore
          .collection('Usuarios')
          .where('celular', isEqualTo: phone)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Número de celular existe, redirigir al dashboard
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Número de celular no existe, redirigir a la página de registro con el número de celular
        Navigator.pushReplacementNamed(
          context,
          '/register',
          arguments: phone,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor ingresa un número de celular y un código válidos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Número de Celular',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Código',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
