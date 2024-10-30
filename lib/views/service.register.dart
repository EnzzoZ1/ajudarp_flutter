import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ServiceRegisterPage extends StatelessWidget {
  const ServiceRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServiceRegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServiceRegistrationScreen extends StatefulWidget {
  const ServiceRegistrationScreen({super.key});

  @override
  _ServiceRegistrationScreenState createState() =>
      _ServiceRegistrationScreenState();
}

class _ServiceRegistrationScreenState extends State<ServiceRegistrationScreen> {
  File? selectedFile;

  // Função para escolher arquivo
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {
      // O usuário cancelou a seleção
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'RP 156',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
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
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Navegar para a página de perfil
                Navigator.pushNamed(
                          context, '/user-profile');
              },
            ),
          ],
        ),
      ),
      body: Container(
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
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.81), // Branco com opacidade de 81%
              borderRadius: BorderRadius.circular(15), // Bordas arredondadas
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Asfalto',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Preencha os campos abaixo com os dados referente ao serviço de "nome do serviço". Após isso, aperte em finalizar e seu serviço será encaminhado para a nossa central de atendimento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Localização',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Imagem da ocorrência',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file),
                      SizedBox(width: 8),
                      Text('Escolher Arquivo'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (selectedFile != null)
                  Column(
                    children: [
                      const Text("Arquivo selecionado:"),
                      const SizedBox(height: 8),
                      Text(
                        selectedFile!.path.split('/').last,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Image.file(
                        selectedFile!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                else
                  const Text("Nenhum arquivo selecionado."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';

// class ServiceRegisterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ServiceRegistrationScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ServiceRegistrationScreen extends StatefulWidget {
//   @override
//   _ServiceRegistrationScreenState createState() =>
//       _ServiceRegistrationScreenState();
// }

// class _ServiceRegistrationScreenState extends State<ServiceRegistrationScreen> {
//   File? selectedFile;

//   // Função para escolher arquivo
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//       });
//     } else {
//       // O usuário cancelou a seleção

//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                   Color(0xFFB60000),
//                   Color(0xFF290000),
//                   ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                    ),
//                   ),
//                 ),
//                 title: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [ 
//                             Container(
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                         colors: [
//                         Color(0xFFB60000),
//                         Color(0xFF290000),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     ),
//                     // Left section with red box
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Text(
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
//                                 // Service page action
//                                 Navigator.pushNamed(
//                                     context, '/user-profile'); // Ensure this matches your routes
//                               },
//                     ),
//                   ],
//                 ),
//               ),
//       //),
//       // body Stack()

//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                 colors: [
//                 Color(0xFFB60000),
//                 Color(0xFF290000),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             ),
            
//             const Center(
//               child: Text(
//                 'Asfalto',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             const Center(
//               child: Text(
//                 'Preencha os campos abaixo com os dados referente ao serviço de "nome do serviço". Após isso, aperte em finalizar e seu serviço será encaminhado para a nossa central de atendimento.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             const Text(
//               'Localização',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             TextFormField(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             const Text(
//               'Descrição',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             TextFormField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             const Text(
//               'Imagem da ocorrência',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: _pickFile,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey.shade400,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.upload_file),
//                   SizedBox(width: 8),
//                   Text('Escolher Arquivo'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             if (selectedFile != null)
//               Column(
//                 children: [
//                   Text("Arquivo selecionado:"),
//                   SizedBox(height: 8),
//                   Text(
//                     selectedFile!.path.split('/').last,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   Image.file(
//                     selectedFile!,
//                     height: 150,
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               )
//             else
//               Text("Nenhum arquivo selecionado."),
//           ],
//         ),
//       ),
//     );
//   }
// }

// =========================================================================================================



// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';

// class ServiceRegisterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ServiceRegistrationScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ServiceRegistrationScreen extends StatefulWidget {
//   @override
//   _ServiceRegistrationScreenState createState() =>
//       _ServiceRegistrationScreenState();
// }

// class _ServiceRegistrationScreenState extends State<ServiceRegistrationScreen> {
//   File? selectedFile;

//   // Função para escolher arquivo
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//       });
//     } else {
//       // O usuário cancelou a seleção
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         backgroundColor: Colors.red.shade700,
//         title: const Text("Cadastro do Serviço"),
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//               colors: [
//               Color(0xFFB60000),
//               Color(0xFF290000),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//         ), 
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [ 
//             // Left section with red box
//             Container(
//               padding:
//                   EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 'RP 156',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//             // Center search input
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
//             // Right profile icon
//             IconButton(
//               icon: Icon(Icons.person),
//               onPressed: () {
//                 // Profile icon action
//               },
//             ),
//           ],
//         ),
              
// // return Scaffold(
// //       body: Stack(
// //         children: [
// //           // Background gradient
// //           Container(
// //             // decoration: BoxDecoration(
// //             //   gradient: LinearGradient(
// //             //     colors: [
// //             //       Colors.red.shade300,
// //             //       Colors.red.shade700,
// //             //     ],
// //             //     begin: Alignment.topCenter,
// //             //     end: Alignment.bottomCenter,
// //             //   ),
// //             // ),
// //             decoration: const BoxDecoration(
// //               gradient: LinearGradient(
// //               colors: [
// //               Color(0xFFB60000),
// //               Color(0xFF290000),
// //           ],
// //           begin: Alignment.topCenter,
// //           end: Alignment.bottomCenter,
// //         ),
// //       ),
// //           ),
// //           Column( 
// //             children: [
// //               // Header
// //               Container(
// //                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.only(
// //                     bottomLeft: Radius.circular(30),
// //                     bottomRight: Radius.circular(30),
// //                   ),
// //                 ),



                
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [ 
// //                     // Left section with red box
// //                     Container(
// //                       padding:
// //                           EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// //                       decoration: BoxDecoration(
// //                         color: Colors.red,
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Text(
// //                         'RP 156',
// //                         style: TextStyle(color: Colors.white, fontSize: 20),
// //                       ),
// //                     ),
// //                     // Center search input
// //                     Expanded(
// //                       child: Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 10),
// //                         child: TextField(
// //                           decoration: InputDecoration(
// //                             hintText: 'Buscar...',
// //                             border: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(30),
// //                               borderSide: BorderSide.none,
// //                             ),
// //                             filled: true,
// //                             fillColor: Colors.grey.shade200,
// //                             prefixIcon: Icon(Icons.search),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     // Right profile icon
// //                     IconButton(
// //                       icon: Icon(Icons.person),
// //                       onPressed: () {
// //                         // Profile icon action
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),

//         // actions: [
//         //   IconButton(
//         //     icon: Icon(Icons.search),
//         //     onPressed: () {},
//         //   ),
//         //   IconButton(
//         //     icon: Icon(Icons.account_circle),
//         //     onPressed: () {},
//         //   ),
//         // ],
//       ),


//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text(
//                 'Asfalto',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             Center(
//               child: Text(
//                 'Preencha os campos abaixo com os dados referente ao serviço de "nome do serviço". Após isso, aperte em finalizar e seu serviço será encaminhado para a nossa central de atendimento.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               'Localização',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             TextFormField(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Descrição',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             TextFormField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Imagem da ocorrência',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: _pickFile,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey.shade400,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.upload_file),
//                   SizedBox(width: 8),
//                   Text('Escolher Arquivo'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             if (selectedFile != null)
//               Column(
//                 children: [
//                   Text("Arquivo selecionado:"),
//                   SizedBox(height: 8),
//                   Text(
//                     selectedFile!.path.split('/').last,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   Image.file(
//                     selectedFile!,
//                     height: 150,
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               )
//             else
//               Text("Nenhum arquivo selecionado."),
//           ],
//         ),
//       ),
//     );
//   }
// }






// // import 'package:flutter/material.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'dart:io';

// // class ServiceRegisterPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: ServiceRegistrationScreen(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// //       //   FilePickerResult? result = await FilePicker.platform.pickFiles();

// //       // if (result != null) {
// //       //   File file = File(result.files.single.path!);
// //       // } else {
// //       //   // User canceled the picker
// //       // }
// // }

// // // FilePickerResult? result = await FilePicker.platform.pickFiles();

// // // if (result != null) {
// // //   File file = File(result.files.single.path!);
// // // } else {
// // //   // User canceled the picker
// // // }


// // class UploadFileScreen extends StatefulWidget {
// //   @override
// //   _UploadFileScreenState createState() => _UploadFileScreenState();
// // }

// // class _UploadFileScreenState extends State<UploadFileScreen> {
// //   File? selectedFile;

// //   Future<void> _pickFile() async {
// //     // Usando o FilePicker para selecionar arquivos
// //     FilePickerResult? result = await FilePicker.platform.pickFiles();

// //     if (result != null) {
// //       setState(() {
// //         selectedFile = File(result.files.single.path!);
// //       });
// //     } else {
// //       // Usuário cancelou a seleção de arquivo
// //     }
// //   }
  
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }


// // class ServiceRegistrationScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[300],
// //       appBar: AppBar(
// //         backgroundColor: Colors.red.shade700,
// //         title: Text("Cadastro do Serviço"),
// //         leading: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Container(
// //             decoration: BoxDecoration(
// //               color: Colors.red.shade900,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Center(
// //               child: Text(
// //                 'RP\n156',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.search),
// //             onPressed: () {},
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.account_circle),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
      
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Center(
// //               child: Text(
// //                 'Asfalto',
// //                 style: TextStyle(
// //                   fontSize: 28,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 8),
// //             Center(
// //               child: Text(
// //                 'Preencha os campos abaixo com os dados referente ao serviço de "nome do serviço". Após isso, aperte em finalizar e seu serviço será encaminhado para a nossa central de atendimento.',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.black54,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 24),
// //             Text(
// //               'Localização',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //             SizedBox(height: 8),
// //             TextFormField(
// //               decoration: InputDecoration(
// //                 filled: true,
// //                 fillColor: Colors.white,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             Text(
// //               'Descrição',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //             SizedBox(height: 8),
// //             TextFormField(
// //               maxLines: 3,
// //               decoration: InputDecoration(
// //                 filled: true,
// //                 fillColor: Colors.white,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             Text(
// //               'Imagem da ocorrência',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //             SizedBox(height: 8),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Implementar funcionalidade para escolher imagem
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.grey.shade400,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(Icons.upload_file),
// //                   SizedBox(width: 8),
// //                   Text('Escolher Arquivo'),
// //                 ],
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             Center(
// //               child: Image.network(
// //                 'https://img.r7.com/images/buraco-asfalto-rua-24012022163824187',
// //                 height: 150,
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }










// // import 'package:flutter/material.dart';

// // class ServiceRegisterPage extends StatelessWidget {
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
// //           child: Container(
// //             width: 300,
// //             height: 400,
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(16),
// //             ),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   children: List.generate(8, (index) {
// //                     return _buildRectangle(_getLabel(index));
// //                   }),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildRectangle(String label) {
// //     return Container(
// //       width: 70,
// //       height: 70,
// //       decoration: BoxDecoration(
// //         color: Colors.grey[300],
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       alignment: Alignment.center,
// //       child: Text(
// //         label,
// //         textAlign: TextAlign.center,
// //         style: TextStyle(color: Colors.black, fontSize: 16),
// //       ),
// //     );
// //   }

// //   String _getLabel(int index) {
// //     const labels = [
// //       "Água",
// //       "Luz e Energia",
// //       "Lixo e Limpeza",
// //       "Animais",
// //       "Saúde e Hospital",
// //       "Horário de Ônibus",
// //       "Segurança",
// //       "Rua e Bairro"
// //     ];
// //     return labels[index % labels.length];
// //   }
// // }











// //=========================================================================================================





// // child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [ 
// //                     // Left section with red box
// //                     Container(
// //                       padding:
// //                           EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// //                       decoration: BoxDecoration(
// //                         color: Colors.red,
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       child: Text(
// //                         'RP 156',
// //                         style: TextStyle(color: Colors.white, fontSize: 20),
// //                       ),
// //                     ),
// //                     // Center search input
// //                     Expanded(
// //                       child: Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 10),
// //                         child: TextField(
// //                           decoration: InputDecoration(
// //                             hintText: 'Buscar...',
// //                             border: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(30),
// //                               borderSide: BorderSide.none,
// //                             ),
// //                             filled: true,
// //                             fillColor: Colors.grey.shade200,
// //                             prefixIcon: Icon(Icons.search),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     // Right profile icon
// //                     IconButton(
// //                       icon: Icon(Icons.person),
// //                       onPressed: () {
// //                         // Profile icon action
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),