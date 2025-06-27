import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  final Function(int) onSelectPage;

  const SidebarMenu({super.key, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF8B0000)),
            child: Image.asset(
              'assets/LOGO.png',
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
  leading: const Icon(Icons.home),
  title: const Text('Receitas Tradicionais'),
  onTap: () {
    Navigator.of(context).pop();
    onSelectPage(0);
  },
),

          ListTile(
  leading: const Icon(Icons.rice_bowl),
  title: const Text('Receitas Orientais'),
  onTap: () {
    Navigator.of(context).pop(); 
    onSelectPage(1);            
  },
),

        ],
      ),
    );
  }
}

