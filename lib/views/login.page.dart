import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _errorMessage;

  // Crie um formatador para o cpf
  final MaskTextInputFormatter _cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##', // Máscara para CPF
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _cpfController.text,
        password: _passwordController.text,
      );

      // Buscar dados do usuário na coleção 'usuarios'
      DocumentSnapshot userDoc = await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Armazenar a sessão do usuário no local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> user = {
          'id': userCredential.user!.uid,
          'name': userData['name'],
          'email': userData['email'],
          'admin': userData['admin'],
        };
        await prefs.setString('user', user.toString());

        Navigator.pushReplacementNamed(context, '/portal');
      } else {
        setState(() {
          _errorMessage = 'Usuário não encontrado.';
        });
        _showErrorMessage();
      }
    } on FirebaseAuthException catch (err) {
      setState(() {
        _errorMessage = 'Login/Email incorretos. Tente novamente.';
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
          child: Container(
            width: 340, // Increased width for the container
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Acesse sua conta',
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
                _buildTextField('Senha',
                    controller: _passwordController,
                    obscureText: true,
                    hintText: 'Senha'),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Add your forgot password logic here
                  },
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // Make the button full width
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: _login,
                    child: const Text(
                      'Acessar conta',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Ainda não tenho conta',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
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
      String? hintText,
      String? labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5), // Espaço entre label e campo de texto
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: labelText, // Usando labelText aqui
            hintText: hintText, // Usando hintText aqui
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 10), // Espaço entre campos
      ],
    );
  }
}
