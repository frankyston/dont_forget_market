import '../models/to_buy.dart';

abstract class IToBuyStorageRepository {
  // Carregar a lista de compras
  Future<List<ToBuy>> loadToBuyList();

  // Adicionar um item na lista de compras
  Future<void> addToBuyItem(ToBuy toBuy);

  // Remover um item da lista de compras
  Future<void> removeToBuyItem(String id);
}
