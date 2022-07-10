import 'item.dart';

class ItemCollection {
  List<String> idList = [];
  List<Item> itemList = [];

  ItemCollection() {
    idList = [];
    itemList = [];
  }

  int length() {
    return idList.length;
  }

  //TOTAL DO CARRINHO:
  double getTotal() {
    double total = 0.0;
    for (var i = 0; i < idList.length; i++) {
      total = total + itemList[i].price;
    }
    return total;
  }

  Item getNodeAtIndex(int index) {
    return itemList[index];
  }

  String getIdAtIndex(int index) {
    return idList[index];
  }

  int getIndexOfId(String id) {
    for (int i = 0; i < idList.length; i++) {
      if (id == idList[i]) {
        return i;
      }
    }
    return -1;
  }

  updateOrInsertNoteOfId(String id, Item item) {
    int index = getIndexOfId(id);
    if (index != -1) {
      itemList[index] = item;
    } else {
      idList.add(id);
      itemList.add(item);
    }
  }

  updateNoteOfId(String id, Item item) {
    int index = getIndexOfId(id);
    if (index != -1) {
      itemList[index] = item;
    }
  }

  deleteNoteOfId(String id) {
    int index = getIndexOfId(id);
    if (index != -1) {
      itemList.removeAt(index);
      idList.removeAt(index);
    }
  }

  insertNoteOfId(String id, Item item) {
    idList.add(id);
    itemList.add(item);
  }
}
