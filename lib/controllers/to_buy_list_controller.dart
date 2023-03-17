import 'package:dont_forget_market/repositories/i_to_buy_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/to_buy.dart';

class ToBuyListController extends ChangeNotifier {
  final IToBuyStorageRepository localStorageRepository;
  final List<ToBuy> toBuyList = [];
  String? error;

  ToBuyListController({required this.localStorageRepository}) {
    onLoadToBuyList();
  }

  Future<void> onLoadToBuyList() async {
    try {
      final toBuyListLoaded = await localStorageRepository.loadToBuyList();
      toBuyList.addAll(toBuyListLoaded);

      notifyListeners();
    } catch (_) {
      error = 'Erro ao tentar carregar lista de compras';
    }
  }

  void onDeleteToBuyItem(String id) async {
    try {
      toBuyList.removeWhere((ToBuy toBuy) => toBuy.id == id);
      notifyListeners();

      await localStorageRepository.removeToBuyItem(id);
    } catch (_) {
      error = 'Erro ao tentar remover item da lista de compras';
    }
  }

  void onAddToBuyListItem(String title, String description) async {
    try {
      final item = ToBuy(
        id: const Uuid().v4(),
        title: title,
        description: description,
      );

      toBuyList.add(item);
      notifyListeners();

      await localStorageRepository.addToBuyItem(item);
    } catch (_) {
      error = 'Erro ao tentar adicionar item na lista de compras';
    }
  }
}
