import 'package:flutter/material.dart';
import 'package:my_recipe_book/models/shopping_lists.dart';

class ShoppingListDetailPage extends StatefulWidget {
  final ShoppingList shoppingList;

  const ShoppingListDetailPage({super.key, required this.shoppingList});

  @override
  State<ShoppingListDetailPage> createState() =>
      _ShoppingListDetailPageState();
}

class _ShoppingListDetailPageState extends State<ShoppingListDetailPage> {
  void _toggleItem(int index) {
    setState(() {
      widget.shoppingList.items[index].isChecked =
          !widget.shoppingList.items[index].isChecked;
      widget.shoppingList.save(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.shoppingList;

    return Scaffold(
      appBar: AppBar(title: Text(list.title)),
      body: ListView.builder(
        itemCount: list.items.length,
        itemBuilder: (_, index) {
          final item = list.items[index];
          return CheckboxListTile(
            title: Text(item.name),
            value: item.isChecked,
            onChanged: (_) => _toggleItem(index),
          );
        },
      ),
    );
  }
}
