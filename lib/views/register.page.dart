import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundPage(),
    );
  }
}

class BackgroundPage extends StatefulWidget {
  const BackgroundPage({super.key});

  @override
  _BackgroundPageState createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _errorMessage;

  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##', // Máscara para CPF
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  final MaskTextInputFormatter _dataNascimentoFormatter =
      MaskTextInputFormatter(
    mask: '##/##/####', // Máscara para data de nascimento
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  final MaskTextInputFormatter _telefoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', // Máscara para telefone
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  final MaskTextInputFormatter _cepFormatter = MaskTextInputFormatter(
    mask: '#####-###', // Máscara para CEP
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'cpf': _cpfController.text,
        'name': _nameController.text,
        'dob': _dobController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'cep': _cepController.text,
        'admin': false,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> user = {
        'id': userCredential.user!.uid,
        'name': _nameController.text,
        'email': _emailController.text,
        'admin': false,
      };
      await prefs.setString('user', user.toString());

      Navigator.pushReplacementNamed(context, '/portal');
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          _errorMessage = 'Este email já está em uso.';
        } else if (e.code == 'weak-password') {
          _errorMessage = 'A senha é muito fraca.';
        } else {
          _errorMessage = 'Ocorreu um erro. Por favor, tente novamente.';
        }
      });
      _showErrorMessage();
    }
  }

  void _showErrorMessage() {
    if (_errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                  _buildTextField('CPF',
                      controller: _cpfController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [_cpfFormatter],
                      hintText: 'XXX.XXX.XXX-XX'),
                  _buildTextField('Nome Civil Completo',
                      controller: _nameController,
                      hintText: 'Qual é seu nome completo'),
                  _buildTextField('Data de Nascimento',
                      controller: _dobController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [_dataNascimentoFormatter],
                      hintText: 'Dia/Mês/Ano'),
                  _buildTextField('Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Informe seu e-mail'),
                  _buildTextField('Telefone',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [_telefoneFormatter],
                      hintText: '(XX) XXXXX-XXXX'),
                  _buildTextField('CEP',
                      controller: _cepController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [_cepFormatter],
                      hintText: 'XXXXX-XXX'),
                  _buildTextField('Senha',
                      controller: _passwordController,
                      obscureText: true,
                      hintText: 'Senha'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: _register,
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
      TextInputType keyboardType = TextInputType.text,
      required TextEditingController controller,
      List<TextInputFormatter>? inputFormatters,
      String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}