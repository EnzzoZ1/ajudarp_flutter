import 'package:flutter/material.dart';

class ServicePortalPage extends StatelessWidget {
  const ServicePortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
          // Background gradient
          Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                colors: [
                Color(0xFFB60000),
                Color(0xFF290000),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            ),
            Column( 
              children: [ 
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),   
                    ),
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ 
                    // Left section with red box
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'RP 156',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    // Center search input
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Buscar...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    // Right profile icon
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.pushNamed(
                          context, '/user-profile'); // Ensure this matches your routes
                      },
                    ),
                  ],
                ),
              ),              
              const SizedBox(height: 20), // Space between header and content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Portal de Atendimento',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // White square with opacity
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Principais Serviços',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            // Service icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.house, 'IPTU'),
                                _buildServiceIcon(Icons.money, 'IPVA'),
                                _buildServiceIcon(Icons.money, 'Árvore'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(
                                    Icons.cleaning_services, 'Coleta'),
                                _buildServiceIcon(Icons.pets, 'Animais'),
                                _buildServiceIcon(
                                    Icons.roofing, 'Pavimentação'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.traffic, 'Esgoto'),
                                _buildServiceIcon(Icons.traffic, 'Trânsito'),
                                _buildServiceIcon(
                                    Icons.directions_bus, 'Ônibus'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Service page action
                                Navigator.pushNamed(
                                    context, '/service-register'); // Ensure this matches your routes
                              },
                              child: const Text('Cadastro do Serviços'),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/service'); // Ensure this matches your routes
                              },
                              child: const Text('Opções de Serviços'),
                            ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/notices'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Notícias Sobre Serviços'),
                            // ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/admin-profile'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Tela do Admin'),
                            // ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/login'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Login'),
                            // ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/user-info'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('user-edit'),
                            // ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/historico'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('Histórico de Solicitações'),
                            // ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushNamed(
                            //         context, '/historico-teste'); // Ensure this matches your routes
                            //   },
                            //   child: const Text('User Teste'),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for service icons
  Widget _buildServiceIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.red.shade200,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: ServicePortalPage(),
//   ));
// }
