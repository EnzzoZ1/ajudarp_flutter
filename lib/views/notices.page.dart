import 'package:flutter/material.dart';

class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade300,
                  Colors.red.shade700,
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
                        // Profile icon action
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
                      // White square with rounded corners
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Feed',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            _buildNewsItem(
                              title: 'Criminalidade',
                              description:
                                  'Homem é preso em riopreto com carro roubado no rio de janeiro',
                              imagePath:
                                  'assets/criminalidade.jpg', // Adicione a imagem correspondente
                            ),
                            const Divider(color: Colors.grey),
                            _buildNewsItem(
                              title: 'Trânsito',
                              description:
                                  'Tempo seco exige cuidado redobrado nas rodovias',
                              imagePath:
                                  'assets/transito.jpg', // Adicione a imagem correspondente
                            ),
                            const Divider(color: Colors.grey),
                            _buildNewsItem(
                              title: 'Saúde',
                              description:
                                  'Família de doador de órgãos é homenageada na Santa Casa',
                              imagePath:
                                  'assets/saude.jpg', // Adicione a imagem correspondente
                            ),
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

  // Widget for news items
  Widget _buildNewsItem(
      {required String title,
      required String description,
      required String imagePath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              imagePath,
              width: 100, // Ajuste o tamanho da imagem conforme necessário
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(description),
        const SizedBox(height: 16), // Espaçamento entre as notícias
      ],
    );
  }
}
