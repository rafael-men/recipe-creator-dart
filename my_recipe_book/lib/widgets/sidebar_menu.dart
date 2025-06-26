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
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF8B0000)),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Receitas Tradicionais'),
            onTap: () => onSelectPage(0),
          ),
          ListTile(
            leading: const Icon(Icons.rice_bowl),
            title: const Text('Receitas Orientais'),
            onTap: () => onSelectPage(1),
          ),
        ],
      ),
    );
  }
}
