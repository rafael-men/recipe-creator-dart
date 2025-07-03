import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_recipe_book/models/shopping_item.dart';
import 'package:my_recipe_book/models/shopping_lists.dart';

class CreateShoppingListPage extends StatefulWidget {
  const CreateShoppingListPage({super.key});

  @override
  State<CreateShoppingListPage> createState() => _CreateShoppingListPageState();
}

class _CreateShoppingListPageState extends State<CreateShoppingListPage> {
  final _recipeController = TextEditingController();
  final List<TextEditingController> _itemControllers = [];

  void _addItemField() {
    setState(() {
      _itemControllers.add(TextEditingController());
    });
  }

  void _removeItemField(int index) {
    setState(() {
      _itemControllers.removeAt(index);
    });
  }

  void _saveList() {
    final recipeName = _recipeController.text.trim();
    if (recipeName.isEmpty || _itemControllers.isEmpty) return;

    final items = _itemControllers
        .where((controller) => controller.text.trim().isNotEmpty)
        .map((controller) => ShoppingItem(name: controller.text.trim()))
        .toList();

    if (items.isEmpty) return;

    final list = ShoppingList(title: recipeName, items: items);
    final shoppingBox = Hive.box<ShoppingList>('shoppingLists');
    shoppingBox.add(list);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _recipeController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Lista de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _recipeController,
              decoration: const InputDecoration(labelText: 'Nome da Receita'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Itens para comprar:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._itemControllers.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final controller = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'Item ${index + 1}',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeItemField(index),
                    ),
                  ],
                );
              },
            ),
            TextButton.icon(
              onPressed: _addItemField,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveList,
              child: const Text('Salvar Lista'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B0000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
