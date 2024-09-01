import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _sexo = 'F'; // Valor predeterminado
  DateTime _selectedDate = DateTime.now(); // Valor predeterminado
  late String _phone; // Para almacenar el número de celular

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtener el número de celular pasado desde la página de login
    final arguments = ModalRoute.of(context)!.settings.arguments as String?;
    if (arguments != null) {
      setState(() {
        _phone = arguments;
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  void _register() async {
    // Recoge los datos
    String nombre = _nombreController.text.trim();
    String apellido = _apellidoController.text.trim();
    String ci = _ciController.text.trim();
    String fechaNacimiento = _fechaController.text.trim();
    String sexo = _sexo;
    String email = _emailController.text.trim();
    String celular = _phone; // Utiliza el número de celular del login

    if (nombre.isNotEmpty &&
        apellido.isNotEmpty &&
        ci.isNotEmpty &&
        fechaNacimiento.isNotEmpty &&
        email.isNotEmpty) {
      // Crea un nuevo documento en Firestore
      await FirebaseFirestore.instance.collection('Usuarios').add({
        'nombres': nombre,
        'apellidos': apellido,
        'ci': ci,
        'fecha_nacimiento': Timestamp.fromDate(_selectedDate),
        'sexo': sexo,
        'correo_electronico': email,
        'celular': celular, // Guarda el número de celular
        'fecha_registro': Timestamp.now(), // Fecha de registro actual
      });

      // Navegar al dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade300,
              Colors.teal.shade300,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ciController,
                decoration: const InputDecoration(
                  labelText: 'CI',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _sexo,
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                items: const [
                  DropdownMenuItem(value: 'F', child: Text('F')),
                  DropdownMenuItem(value: 'M', child: Text('M')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sexo = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.teal.shade700,
                ),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
