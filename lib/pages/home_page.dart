import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/to_buy_list_controller.dart';
import '../models/to_buy.dart';
import 'add_to_buy_item_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final toBuyListController = Provider.of<ToBuyListController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Não esquecer no SuperMercado'),
      ),
      body: toBuyListController.toBuyList.isEmpty
          ? const Center(
              child: Text(
                'Você não possui itens para comprar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              itemCount: toBuyListController.toBuyList.length,
              itemBuilder: (_, int index) {
                ToBuy item = toBuyListController.toBuyList[index];
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    textColor: Colors.black,
                    leading: CircleAvatar(
                      child: Text(item.title[0]),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      item.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      iconSize: 30,
                      color: Colors.red,
                      onPressed: () =>
                          toBuyListController.onDeleteToBuyItem(item.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: toBuyListController,
              child: const AddToBuyItemPage(),
            ),
          ),
        ),
        tooltip: 'Adicionar item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
