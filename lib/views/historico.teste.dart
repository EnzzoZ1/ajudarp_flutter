import 'package:flutter/material.dart';

class UserTeste extends StatelessWidget {
  const UserTeste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB60000), Color(0xFF290000)],
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            height: 600,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.81),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_circle, size: 160, color: Colors.grey),
                const SizedBox(height: 20),
                const Text(
                  "User Name",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Cor vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(240, 80), // Tamanho fixo do botão
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/aconpanhamento');
                  },
                  child: const Text(
                    'Acompanhamento de Serviço',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Cor vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(240, 80), // Tamanho fixo do botão
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/historico');
                  },
                  child: const Text(
                    'Histórico de Solicitações',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Cor vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(240, 80), // Tamanho fixo do botão
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/user-info');
                  },
                  child: const Text(
                    'Editar Informações Pessoais',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          // Add navigation logic here
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.grey;
              }
              return null;
            },
          ),
        ),
        child: Text(text),
      ),
    );
  }
}