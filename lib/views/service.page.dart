import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        backgroundColor: const Color(0xFFB60000),
        toolbarHeight: 90,
        flexibleSpace: Container(
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

      ),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: Container(
        //     padding:
        //       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //         decoration: BoxDecoration(
        //           color: Colors.red,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //           child: const Text(
        //             'RP 156',
        //             style: TextStyle(color: Colors.white, fontSize: 20),
        //           ),
        //   ),
        //   title: const TextField(
        //     decoration: InputDecoration(
        //       hintText: 'Search',
        //       prefixIcon: Icon(Icons.search),
        //       border: InputBorder.none,
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.person),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
        body: const GradientBackground(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB60000),
            Color(0xFF290000),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: ResponsiveContainer(),
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return SelectableBox(text: _getText(index));
                        }),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return SelectableBox(text: _getText(index + 6));
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Widget buildButton(String text) {
  //   return Container(
  //     width: 140,
  //     height: 120,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     margin: EdgeInsets.symmetric(vertical: 5),
  //     child: ElevatedButton(
  //       onPressed: () {},
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: Colors.black, backgroundColor: Colors.white,
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(fontSize: 16),
  //       ),
  //     ),
  //   );
  // }
}

String _getText(int index) {
    const texts = [
      "Água",
      "Luz e Energia",
      "Lixo e Limpeza",
      "Animais",
      "Saúde e Hospital",
      "Horário de Ônibus",
      "Segurança",
      "Rua e Bairro",
    ];
    return texts[index % texts.length];
  }

class SelectableBox extends StatefulWidget {
  final String text;

  const SelectableBox({super.key, required this.text});

  @override
  _SelectableBoxState createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<SelectableBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: 130,
        height: 60,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFFE5E5E) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(color: Colors.black.withOpacity(0.5)),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}


            





// import 'package:flutter/material.dart';

// class ServicePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ServicesPage(),
//     );
//   }
// }

// class ServicesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFB60000),
//         toolbarHeight: 90,
//         flexibleSpace: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Text(
//                 'RP 156',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Buscar...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.person),
//               onPressed: () {
//                 // Navegar para a página de perfil
//                 Navigator.pushNamed(context, '/user-profile');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(


// // SizedBox(height: 20), // Space between header and content
// // //               Expanded(
// // //                 child: SingleChildScrollView(
// // //                   child: Column(
// // //                     children: [
// // //                       // Title
// // //                       const Padding(
// // //                         padding: EdgeInsets.all(20),
// // //                         child: Text(
// // //                           'Setores Mais Acessados',
// // //                           style: TextStyle(
// // //                               fontSize: 24, fontWeight: FontWeight.bold),
// // //                         ),
// // //                       ),




//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             color: Colors.red[800],
//             child: const Text(
//               'Serviços Mais Acessados',
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.grey[300],
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 padding: EdgeInsets.all(16),
//                 children: [
//                   _buildServiceButton('Obstrução de Ruas'),
//                   _buildServiceButton('Bueiro'),
//                   _buildServiceButton('Calçada'),
//                   _buildServiceButton('Asfalto'),
//                   _buildServiceButton('Terreno Baldio'),
//                   _buildServiceButton('Semáforo'),
//                   _buildServiceButton('Faixas de Trânsito'),
//                   _buildServiceButton('Cabos Soltos'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildServiceButton(String title) {
//     return SizedBox(
//       width: double.infinity,
//       height: 60, // Definindo uma altura padrão para os botões
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           foregroundColor: Colors.black, backgroundColor: Colors.white, // Cor do texto preta
//           textStyle: TextStyle(fontWeight: FontWeight.bold),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0), // Bordas retangulares (sem arredondamento)
//           ),
//         ),
//         onPressed: () {},
//         child: Text(title, textAlign: TextAlign.center),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';

// class ServicePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ServicesPage(),
//     );
//   }
// }

// class ServicesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red[800],
//         leading: Container(
//           padding: EdgeInsets.all(10),
//           child: CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Text(
//               'RP 156',
//               style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         title: const TextField(
//           decoration: InputDecoration(
//             hintText: 'Search',
//             prefixIcon: Icon(Icons.search),
//             border: InputBorder.none,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             color: Colors.red[800],
//             child: const Text(
//               'Serviços Mais Acessados',
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.grey[300],
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 padding: EdgeInsets.all(16),
//                 children: [
//                   _buildServiceButton('Obstrução de Ruas'),
//                   _buildServiceButton('Bueiro'),
//                   _buildServiceButton('Calçada'),
//                   _buildServiceButton('Asfalto'),
//                   _buildServiceButton('Terreno Baldio'),
//                   _buildServiceButton('Semáforo'),
//                   _buildServiceButton('Faixas de Trânsito'),
//                   _buildServiceButton('Cabos Soltos'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildServiceButton(String title) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.black, backgroundColor: Colors.white,
//         textStyle: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       onPressed: () {},
//       child: Text(title, textAlign: TextAlign.center),
//     );
//   }
// }




















// import 'package:flutter/material.dart';

// class ServicePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                 Color(0xFFB60000),
//                 Color(0xFF290000),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           Column( 
//             children: [
//               // Header
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),



                
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [ 
//                     // Left section with red box
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         'RP 156',
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ),
//                     // Center search input
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Buscar...',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide.none,
//                             ),
//                             filled: true,
//                             fillColor: Colors.grey.shade200,
//                             prefixIcon: Icon(Icons.search),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Right profile icon
//                     IconButton(
//                       icon: Icon(Icons.person),
//                       onPressed: () {
//                         Navigator.pushNamed(
//                           context, '/user-profile');
//                       },
//                     ),
//                   ],
//                 ),
//               ),

              
//               SizedBox(height: 20), // Space between header and content
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // Title
//                       const Padding(
//                         padding: EdgeInsets.all(20),
//                         child: Text(
//                           'Setores Mais Acessados',
//                           style: TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       // White square with opacity


                      
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.8),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
                            
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: 
//                               List.generate(8, (index) {
//                                 // add a padding to the box
//                                 Padding(
//                                   //padding: const EdgeInsets.all(18.0),
//                                   padding: EdgeInsets.symmetric(vertical: 200),
//                                   child: SelectableBox(text: _getText(index)),
//                                 );
//                                 return SelectableBox(text: _getText(index));
//                               }),
//                               // generate a code that set the size of the box
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: 
//                               List.generate(8, (index) {
//                                 Padding(
//                                   padding: const EdgeInsets.all(18.0),
//                                   child: 
//                                   // SizedBox(
//                                   //   height: 100,
//                                   //   width: 100,
//                                   //   child: SelectableBox(text: _getText(index)),
//                                   // ),
//                                   SelectableBox(text: _getText(index)),
//                                 );
//                                 return SelectableBox(text: _getText(index));
//                               }),
//                             ),
//                           ],
//                         ),
//                         // child: Column(
//                         //   mainAxisAlignment: MainAxisAlignment.center,
//                         //   children: [
//                         //     Column(
//                         //       mainAxisAlignment: MainAxisAlignment.center,
//                         //       children: List.generate(8, (index) {
//                         //         return SelectableBox(text: _getText(index));
//                         //       }),
//                         //     ),
//                         //     Column(
//                         //       mainAxisAlignment: MainAxisAlignment.center,
//                         //       children: List.generate(8, (index) {
//                         //         return SelectableBox(text: _getText(index));
//                         //       }),
//                         //     ),
//                         //   ],
//                         //   children: List.generate(8, (index) {
//                         //     return SelectableBox(text: _getText(index));
//                         //   }),
//                         // ),

//                         // child: Column(
//                         //   mainAxisAlignment: MainAxisAlignment.center,
//                         //   children: List.generate(8, (index) {
//                         //     return SelectableBox(text: _getText(index));
//                         //   }),
//                         // ),

//                       ),


                      

//                       // Container(
//                       //   margin: EdgeInsets.symmetric(horizontal: 20),
//                       //   padding: EdgeInsets.all(20),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white.withOpacity(0.3),
//                       //     borderRadius: BorderRadius.circular(20),
//                       //   ),
//                       //   child: Column(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: List.generate(8, (index) {
//                       //       return SelectableBox(text: _getText(index + 8));
//                       //     }),
//                       //   ),
//                       // ),
//                       //),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildServiceIcon(IconData icon, String label) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.red.shade200,
//           child: Icon(icon, color: Colors.white),
//         ),
//         const SizedBox(height: 5, width: 150),

//         Text(label),
//       ],
//     );
//   }
// }


// // import 'package:flutter/material.dart';

// // class ServicePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         body: GradientBackground(),
// //       ),
// //     );
// //   }
// // }

// // class GradientBackground extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [
// //             Color(0xFFB60000),
// //             Color(0xFF290000),
// //           ],
// //           begin: Alignment.topCenter,
// //           end: Alignment.bottomCenter,
// //         ),
// //       ),
// //       child: Center(
// //         child: Opacity(
// //           opacity: 0.81,
// //           child: 
// //             Container(
// //               margin: EdgeInsets.symmetric(horizontal: 20),
// //               padding: EdgeInsets.all(20),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.6),
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),

// //             // child: Column(
// //             //   mainAxisAlignment: MainAxisAlignment.center,
// //             //   children: [
// //             //     Expanded(
// //             //       child: Row(
// //             //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             //         children: [
// //             //           Column(
// //             //             mainAxisAlignment: MainAxisAlignment.center,
// //             //             children: List.generate(8, (index) {
// //             //               return SelectableBox(text: _getText(index));
// //             //             }),
// //             //           ),
// //             //           Column(
// //             //             mainAxisAlignment: MainAxisAlignment.center,
// //             //             children: List.generate(8, (index) {
// //             //               return SelectableBox(text: _getText(index + 8));
// //             //             }),
// //             //           ),
// //             //         ],
// //             //       ),
// //             //     ),
// //             //   ],
// //             // ),

//   String _getText(int index) {
//     const texts = [
//       "Água",
//       "Luz e Energia",
//       "Lixo e Limpeza",
//       "Animais",
//       "Saúde e Hospital",
//       "Horário de Ônibus",
//       "Segurança",
//       "Rua e Bairro",
//     ];
//     return texts[index % texts.length];
//   }

// class SelectableBox extends StatefulWidget {
//   final String text;

//   SelectableBox({required this.text});

//   @override
//   _SelectableBoxState createState() => _SelectableBoxState();
// }

// class _SelectableBoxState extends State<SelectableBox> {
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: Container(
//         margin: EdgeInsets.all(5),
//         padding: EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           color: _isHovered ? Color(0xFFFE5E5E) : Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.black.withOpacity(0.5)),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           widget.text,
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }
// }
