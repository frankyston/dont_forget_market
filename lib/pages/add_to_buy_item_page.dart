import 'package:dont_forget_market/controllers/to_buy_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToBuyItemPage extends StatefulWidget {
  const AddToBuyItemPage({super.key});

  @override
  State<AddToBuyItemPage> createState() => _AddToBuyItemPageState();
}

class _AddToBuyItemPageState extends State<AddToBuyItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleTEC = TextEditingController();
  final _descriptionTEC = TextEditingController();

  void _onSubmitForm(ToBuyListController toBuyListController) {
    if (_formKey.currentState!.validate()) {
      toBuyListController.onAddToBuyListItem(
        _titleTEC.text,
        _descriptionTEC.text,
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final toBuyListController = Provider.of<ToBuyListController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleTEC,
                decoration: const InputDecoration(
                  hintText: 'Título',
                ),
                validator: (String? title) {
                  if (title == null || title.isEmpty) {
                    return 'Título é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionTEC,
                decoration: const InputDecoration(
                  hintText: 'Descrição',
                ),
                validator: (String? description) {
                  if (description == null || description.isEmpty) {
                    return 'Descrição é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _onSubmitForm(toBuyListController),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                ),
                child: const Text(
                  'Adicionar item',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
