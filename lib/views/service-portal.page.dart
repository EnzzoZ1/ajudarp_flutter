import 'package:flutter/material.dart';
import 'app-bar.dart';

class ServicePortalPage extends StatelessWidget {
  const ServicePortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'RP 156'),
      body: Stack(
          children: [
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
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Portal de Atendimento',
                          style: TextStyle(
                              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.add_road_rounded, 'Bairro', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.house, 'IPVA', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.trending_neutral, 'Árvore', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.cleaning_services, 'Coleta', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.pets, 'Animais', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.roofing, 'IPTU', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceIcon(Icons.traffic, 'Esgoto', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.traffic, 'Trânsito', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                                _buildServiceIcon(Icons.directions_bus, 'Ônibus', () {
                                  Navigator.pushNamed(context, '/service');
                                }),
                              ],
                            ),
                         const SizedBox(height: 20),
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

  Widget _buildServiceIcon(IconData icon, String label, [VoidCallback? onTap]) {
  return Center(
    child: Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.red.shade200,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Text(label),
      ],
    ),
  );
}
}