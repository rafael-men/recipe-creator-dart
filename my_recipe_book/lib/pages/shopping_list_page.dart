import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_recipe_book/models/shopping_lists.dart';
import 'package:my_recipe_book/pages/ShoppingListDetailPage.dart';
import 'package:my_recipe_book/pages/create_shopping_list_page.dart';


class ShoppingListsPage extends StatefulWidget {
  const ShoppingListsPage({super.key});

  @override
  State<ShoppingListsPage> createState() => _ShoppingListsPageState();
}

class _ShoppingListsPageState extends State<ShoppingListsPage> {
  final shoppingBox = Hive.box<ShoppingList>('shoppingLists');

  void _deleteList(int index) async {
    await shoppingBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lists = shoppingBox.values.toList();

    return Scaffold(
      body: lists.isEmpty
          ? const Center(child: Text('Nenhuma lista de compras criada'))
          : ListView.builder(
              itemCount: lists.length,
              itemBuilder: (_, index) {
                final list = lists[index];
                return ListTile(
                  title: Text(list.title),
                  subtitle:
                      Text('${list.items.where((item) => item.isChecked).length}/${list.items.length} itens comprados'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteList(index),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ShoppingListDetailPage(shoppingList: list),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateShoppingListPage()),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF8B0000),
      ),
    );
  }
}
