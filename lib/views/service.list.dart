import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'app-bar.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServiceListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isAdmin = false;
  String userString = '';
  String userId = '';
  late TabController _tabController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    if (userString != null) {
      userString = userString.replaceAll(RegExp(r'(\w+):'), r'"\1":').replaceAll("'", '"');
      Map<String, dynamic> user = jsonDecode(userString);
      if (user.containsKey('admin')) {
        bool isAdmin = user['admin'];
        setState(() {
          this.userId = user['id'];
          this.isAdmin = isAdmin;
          this.userString = user.toString();
        });
      }
    }
  }

  void _navigateToServiceUpdatePage(String serviceId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceUpdatePage(serviceId: serviceId, isAdmin: isAdmin),
      ),
    );
  }

  Stream<QuerySnapshot> _getServiceStream(List<String> statuses) {
    Query query = _firestore.collection('servicos').where('status', whereIn: statuses);
    if (!isAdmin) {
      query = query.where('userId', isEqualTo: userId);
    }
    if (searchQuery.isNotEmpty) {
      query = query.where('title', isGreaterThanOrEqualTo: searchQuery).where('title', isLessThanOrEqualTo: searchQuery + '\uf8ff');
    }
    return query.snapshots();
  }

  Widget _buildServiceTable(Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final services = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Serviço')),
                DataColumn(label: Text('Situação')),
                DataColumn(label: Text('Data')),
                DataColumn(label: Text('Título')),
              ],
              rows: services.map((service) {
                final data = service.data() as Map<String, dynamic>;
                final serviceTitle = data['title'] ?? 'Sem título';
                final serviceStatus = data['status'] ?? 'Em andamento';
                final timestamp = data['timestamp'] as Timestamp;
                final date = DateFormat('dd/MM/yyyy').format(timestamp.toDate());
                final imageUrl = data['imageUrl'];
                final serviceId = service.id;

                Color statusColor;
                switch (serviceStatus) {
                  case 'Concluído':
                    statusColor = Colors.green;
                    break;
                  case 'Cancelado':
                    statusColor = Colors.red;
                    break;
                  default:
                    statusColor = Colors.amber;
                }

                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          if (imageUrl != null && imageUrl.isNotEmpty)
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                  onError: (error, stackTrace) {
                                    print('Erro ao carregar imagem: $error');
                                  },
                                ),
                              ),
                            ),
                          const SizedBox(width: 8),
                          Text(serviceTitle),
                        ],
                      ),
                      onTap: () => _navigateToServiceUpdatePage(serviceId),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          serviceStatus,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () => _navigateToServiceUpdatePage(serviceId),
                    ),
                    DataCell(
                      Text(date),
                      onTap: () => _navigateToServiceUpdatePage(serviceId),
                    ),
                    DataCell(
                      Text(serviceTitle),
                      onTap: () => _navigateToServiceUpdatePage(serviceId),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB60000),
        toolbarHeight: 90,
        flexibleSpace: CustomAppBar(title: 'RP 156'),
        
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pendentes/Em andamento'),
            Tab(text: 'Concluídos/Cancelados'),
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
              color: const Color.fromRGBO(255, 255, 255, 0.81),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Acompanhamento do serviço',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildServiceTable(_getServiceStream(['Pendente', 'Em andamento'])),
                      _buildServiceTable(_getServiceStream(['Concluído', 'Cancelado'])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceUpdatePage extends StatefulWidget {
  final String serviceId;
  final bool isAdmin;

  const ServiceUpdatePage({super.key, required this.serviceId, required this.isAdmin});

  @override
  _ServiceUpdatePageState createState() => _ServiceUpdatePageState();
}

class _ServiceUpdatePageState extends State<ServiceUpdatePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedStatus;
  String title = '';
  String description = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  Future<void> _loadServiceData() async {
    DocumentSnapshot serviceDoc = await _firestore.collection('servicos').doc(widget.serviceId).get();
    if (serviceDoc.exists) {
      Map<String, dynamic> serviceData = serviceDoc.data() as Map<String, dynamic>;
      print(serviceData);
      setState(() {
        title = serviceData['title'] ?? '';
        description = serviceData['description'] ?? '';
        imageUrl = serviceData['imageUrl'] ?? '';
        selectedStatus = serviceData['status'];
      });
    }
  }

  Future<void> _updateService() async {
    try {
      await _firestore.collection('servicos').doc(widget.serviceId).update({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'status': selectedStatus,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Serviço atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        selectedStatus = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar serviço: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _cancelService() async {
    try {
      await _firestore.collection('servicos').doc(widget.serviceId).update({
        'status': 'Cancelado',
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Serviço cancelado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cancelar serviço: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteService() async {
    try {
      await _firestore.collection('servicos').doc(widget.serviceId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Serviço excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir serviço: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.81),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Título'),
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  controller: TextEditingController(text: title),
                  enabled: widget.isAdmin,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  controller: TextEditingController(text: description),
                  enabled: widget.isAdmin,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(labelText: 'URL da Imagem'),
                  onChanged: (value) {
                    setState(() {
                      imageUrl = value;
                    });
                  },
                  controller: TextEditingController(text: imageUrl),
                  enabled: widget.isAdmin,
                ),
                const SizedBox(height: 8),
             if (imageUrl.isNotEmpty)
  Center(
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      height: 150,
      width: 150,
      fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Text('Erro ao carregar imagem'),
    ),
  ),
                const SizedBox(height: 16),
                if (widget.isAdmin)
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                if (!widget.isAdmin)
                  TextField(
                    decoration: const InputDecoration(labelText: 'Status'),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    controller: TextEditingController(text: selectedStatus),
                    enabled: widget.isAdmin,
                  ),
                const SizedBox(height: 8),
                if (widget.isAdmin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Cancelado';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == 'Cancelado' ? Colors.red : Colors.grey.withOpacity(0.5),
                        ),
                        child: const Text('Cancelado'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Pendente';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == 'Pendente' ? Colors.red : Colors.grey.withOpacity(0.5),
                        ),
                        child: const Text('Pendente'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Em andamento';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == 'Em andamento' ? Colors.red : Colors.grey.withOpacity(0.5),
                        ),
                        child: const Text('Em andamento'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Concluído';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == 'Concluído' ? Colors.red : Colors.grey.withOpacity(0.5),
                        ),
                        child: const Text('Concluído'),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (widget.isAdmin)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: selectedStatus == null ? null : _updateService,
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                if (!widget.isAdmin && selectedStatus == 'Pendente')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: _cancelService,
                      child: const Text(
                        'Cancelar serviço',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                if (widget.isAdmin)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: _deleteService,
                      child: const Text(
                        'Excluir',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}