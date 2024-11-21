import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'user.profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'service-portal.page.dart';
import 'service.page.dart';
import 'user.info.dart' as custom_user_info;
import 'service.list.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(90);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> pages = [
    {'name': 'Portal', 'route': ServicePortalPage()},
    {'name': 'Serviçõs', 'route': ServicePage()},
    {'name': 'Perfil de usuário', 'route': UserProfilePage()},
    {'name': 'Informações do usuário', 'route': custom_user_info.UserInfo()},
    {'name': 'Listagem de serviços', 'route': ServiceListPage()},
  ];

  User? _user;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(_user!.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _profileImageUrl = userData['profileImageUrl'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
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
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TypeAheadField<Map<String, dynamic>>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: searchController,
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
                suggestionsCallback: (pattern) {
                  return pages.where((page) =>
                      page['name'].toLowerCase().contains(pattern.toLowerCase()));
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion['name']),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => suggestion['route']),
                  );
                },
              ),
            ),
          ),
          IconButton(
            icon: _profileImageUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(_profileImageUrl!),
                  )
                : const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}