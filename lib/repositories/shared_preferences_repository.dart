import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../errors/repository_exception.dart';
import '../models/to_buy.dart';
import 'i_to_buy_storage_repository.dart';

class SharedPreferenceRepository implements IToBuyStorageRepository {
  final toBuyListKey = 'TO_BUY_LIST_KEY';

  @override
  // PS. ToBuy é um model
  Future<List<ToBuy>> loadToBuyList() async {
    try {
      // pegar a instância de shared preferences
      final prefs = await SharedPreferences.getInstance();

      // Carregar o JSON da lista se existir
      final toBuyListJSON = prefs.getString(toBuyListKey);

      // Criar uma lista qus será retornada
      final List<ToBuy> listToReturn = [];

      // Checar se o JSON existe.
      if (toBuyListJSON != null) {
        // Transformar o JSON para List<Map<String, dynamic>>
        final toBuyListDecoded = jsonDecode(toBuyListJSON);

        // Transformar o List<Map<String, dynamic>> para List<ToBuy>
        final toBuyList = (toBuyListDecoded as List)
            .map((toBuy) => ToBuy.fromMap(toBuy))
            .toList();
        // Adicionar todos os items na lista de retorno
        listToReturn.addAll(toBuyList);
      }

      return listToReturn;
    } catch (_) {
      throw RepositoryException('Erro ao carregar lista de compras');
    }
  }

  @override
  Future<void> addToBuyItem(ToBuy toBuy) async {
    try {
      // pegar a instância de shared preferences
      final prefs = await SharedPreferences.getInstance();

      // carregar a lista
      final List<ToBuy> toBuyList = await loadToBuyList();

      // Adicionar o item na lista
      toBuyList.add(toBuy);

      // Transformar a lista em List<Map<String, dynamic>>
      final toBuyListMap = toBuyList.map((toBuy) => toBuy.toMap()).toList();

      // Transformar o List<Map<String, dynamic>> para JSON
      final toBuyListJSON = jsonEncode(toBuyListMap);

      // Salvar a nova lista no localstorage
      prefs.setString(toBuyListKey, toBuyListJSON);
    } catch (_) {
      throw RepositoryException('Erro ao adicionar item na lista de compras');
    }
  }

  @override
  Future<void> removeToBuyItem(String id) async {
    try {
      // pegar a instância de shared preferences
      final prefs = await SharedPreferences.getInstance();

      // carregar a lista
      final List<ToBuy> toBuyList = await loadToBuyList();

      // remover o item da lista
      toBuyList.removeWhere((toBuy) => toBuy.id == id);

      // transformar a lista em List<Map<String, dynamic>>
      final toBuyListMap = toBuyList.map((toBuy) => toBuy.toMap()).toList();

      // Transformar o List<Map<String, dynamic>> para JSON
      final toBuyListJSON = jsonEncode(toBuyListMap);

      // Salvar a nova lista no localstorage
      prefs.setString(toBuyListKey, toBuyListJSON);
    } catch (_) {
      throw RepositoryException('Erro ao remover item na lista de compras');
    }
  }
}
