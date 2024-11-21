import 'package:flutter/material.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 100,
                height: 100,
                color: const Color.fromARGB(255, 201, 201, 201),
                child: IconButton(
                  icon: const Icon(Icons.person, size: 80),
                  onPressed: () {
                    Navigator.pushNamed(context, '/user-profile');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Cor vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(240, 80), // Tamanho fixo do botão
                  ),
                  child: const Text(
                    'Histórico de Pedidos',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Cor vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(240, 80), // Tamanho fixo do botão
                  ),
                  child: const Text(
                    'Editar Informações Pessoais',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0), // Cor vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fixedSize: const Size(240, 80), // Tamanho fixo do botão
                  ),
                  child: const Text(
                    'Acompanhamento do Serviço',
                    style: TextStyle(color: Colors.white), // Cor do texto
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}