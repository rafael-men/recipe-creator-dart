import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SidebarMenu extends StatelessWidget {
  final Function(int) onSelectPage;

  const SidebarMenu({super.key, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
  decoration: const BoxDecoration(color: Color(0xFF8B0000)),
  child: FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get(),
    builder: (context, snapshot) {
      String greeting = 'Olá!';
      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        final data = snapshot.data!.data() as Map<String, dynamic>?;
        if (data != null && data['nickname'] != null) {
          greeting = 'Olá, ${data['nickname']}';
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/LOGO.png',
            height: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          Text(
            greeting,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'RobotoSlab',
            ),
          ),
        ],
      );
    },
  ),
),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Receitas Tradicionais',
              style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onSelectPage(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.rice_bowl),
            title: const Text(
              'Receitas Orientais',
              style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onSelectPage(1);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Sair',
              style: TextStyle(fontFamily: 'RobotoSlab', fontSize: 18),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
