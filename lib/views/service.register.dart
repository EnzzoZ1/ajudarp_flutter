import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'app-bar.dart';

class ServiceRegisterPage extends StatelessWidget {
  final String item;

  const ServiceRegisterPage({super.key, this.item = 'Outro'});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ServiceRegistrationScreen(item: item),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServiceRegistrationScreen extends StatefulWidget {
  final String item;

  const ServiceRegistrationScreen({super.key, required this.item});

  @override
  _ServiceRegistrationScreenState createState() =>
      _ServiceRegistrationScreenState();
}

class _ServiceRegistrationScreenState extends State<ServiceRegistrationScreen> {
  File? selectedFile;
  Uint8List? selectedFileBytes;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função para escolher arquivo
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      if (kIsWeb) {
        if (result.files.single.size > 25 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('O arquivo selecionado é muito grande. O tamanho máximo é 25 MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        setState(() {
          selectedFileBytes = result.files.single.bytes;
        });
      } else {
        File file = File(result.files.single.path!);
        if (file.lengthSync() > 25 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('O arquivo selecionado é muito grande. O tamanho máximo é 25 MB.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        setState(() {
          selectedFile = file;
        });
      }
    } else {
      // O usuário cancelou a seleção
    }
  }

  Future<void> _removeFile() async {
    setState(() {
      selectedFile = null;
      selectedFileBytes = null;
    });
  }

  Future<void> _registerService() async {
    try {
      String? imageUrl;
      String? userId;
    if (selectedFile != null || selectedFileBytes != null) {
  // Upload da imagem para o Firebase Storage
  final storageRef = FirebaseStorage.instance
      .ref()
      .child('service_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

  final metadata = SettableMetadata(
    contentType: 'image/jpeg', // Defina o tipo de conteúdo correto
  );

  if (kIsWeb) {
    await storageRef.putData(selectedFileBytes!, metadata);
  } else {
    await storageRef.putFile(selectedFile!, metadata);
  }

  imageUrl = await storageRef.getDownloadURL();
}

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userString = prefs.getString('user');
      if (userString != null) {
        userString = userString.replaceAll(RegExp(r'(\w+):'), r'"\1":').replaceAll("'", '"');
        Map<String, dynamic> user = jsonDecode(userString);
        if (user.containsKey('admin')) {
          userId = user['id'];
        }
      }
  
      // Enviar dados para o Firestore
      await _firestore.collection('servicos').add({
        'title': widget.item,
        'status': 'Pendente',
        'location': _locationController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': userId,
      });

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Serviço registrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Limpar os campos
      _locationController.clear();
      _descriptionController.clear();
      setState(() {
        selectedFile = null;
        selectedFileBytes = null;
      });
    } catch (e) {
      // Mostrar mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao registrar serviço: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<String>> _fetchLocationSuggestions(String query) async {
    final response = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['display_name'] as String).toList();
    } else {
      throw Exception('Erro ao carregar sugestões de localização');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: CustomAppBar(title: 'RP 156'),
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
          child: SingleChildScrollView(
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
                  Center(
                    child: Text(
                      widget.item,
                      style: const TextStyle(
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
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _locationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    suggestionsCallback: _fetchLocationSuggestions,
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _locationController.text = suggestion;
                    },
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
                    controller: _descriptionController,
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
                  if (selectedFile != null || selectedFileBytes != null)
                    Column(
                      children: [
                        const Text("Arquivo selecionado:"),
                        const SizedBox(height: 8),
                        Text(
                          selectedFile != null
                              ? selectedFile!.path.split('/').last
                              : 'Arquivo selecionado na web',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (selectedFile != null)
                          Image.file(
                            selectedFile!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        else if (selectedFileBytes != null)
                          Image.memory(
                            selectedFileBytes!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _removeFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete),
                              SizedBox(width: 8),
                              Text('Remover Arquivo'),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: _registerService,
                      child: const Text(
                        'Finalizar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}