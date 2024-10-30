import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundPage(),
    );
  }
}

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/cidade-de-sao-jose-do-rio-preto.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
        ),
        Positioned(
          top: 40,
          left: (MediaQuery.of(context).size.width - 274) / 2,
          child: Container(
            width: 274,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'AjudaRP',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: 340,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 120, bottom: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Crie sua conta',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('CPF'),
                  _buildTextField('Nome Civil Completo'),
                  _buildTextField('Data de Nascimento',
                      keyboardType: TextInputType.datetime),
                  _buildTextField('Email',
                      keyboardType: TextInputType.emailAddress),
                  _buildTextField('Telefone',
                      keyboardType: TextInputType.phone),
                  _buildTextField('CEP', keyboardType: TextInputType.number),
                  _buildTextField('Senha', obscureText: true),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        // Add your registration logic here
                      },
                      child: const Text(
                        'Registrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Voltar para login',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5), // Space between label and text field
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10), // Space between fields
      ],
    );
  }
}
