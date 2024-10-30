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
              borderRadius: BorderRadius.circular(50), // Borda circular
              child: Container(
                width: 100, // Largura desejada
                height: 100, // Altura desejada
                color: const Color.fromARGB(255, 201, 201, 201), // Cor vermelha
                child: IconButton(
                  icon: const Icon(Icons.person, size: 80), // Tamanho do ícone
                  onPressed: () {
                    Navigator.pushNamed(context, '/user-profile'); // Verifique se isso corresponde às suas rotas
                  },
                ),
              ),
            ),
            // IconButton(
            //     icon: Icon(Icons.person),
            //     onPressed: () {
            //       Navigator.pushNamed(
            //         context, '/user-profile'); // Ensure this matches your routes
            //     },
            //   ),
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






// import 'package:flutter/material.dart';

// class AdminProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: UserProfileScreen(),
//     );
//   }
// }

// class UserProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Perfil do Usuário'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Substitua pela URL da sua imagem
//             ),
//             SizedBox(height: 16),
//             const Text(
//               'Nome do Usuário',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 32),
//             Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 0, 17, 255),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   ),
//                   child: Text('Histórico de Pedidos'),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 0, 17, 255),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   ),
//                   child: Text('Editar Informações Pessoais'),
//                 ),
                
                
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 0, 17, 255),
                    
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   ),
//                   child: Text('Acompanhamento do Serviço'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
