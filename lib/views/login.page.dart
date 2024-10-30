import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
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
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/portal');
                    },
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
}
