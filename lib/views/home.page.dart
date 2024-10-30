import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Participe da gestão da cidade',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 44,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Com nosso aplicativo você participa na melhoria da nossa cidade.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/login'); // Ensure this matches your routes
                },
                child: const Text('Acesse aqui'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
