import '../model/item.dart';
import '../model/items.dart';
import '../model/complete_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServer {
// Atributo que irá afunilar todas as consultas
  static FirestoreServer helper = FirestoreServer._createInstance();
// Construtor privado
  FirestoreServer._createInstance();

// uid do usuário logado
  String? uid;

// Ponto de acesso com o servidor
  final CollectionReference itemCollection = FirebaseFirestore.instance.collection("items");
  final CollectionReference shoeCollection = FirebaseFirestore.instance.collection("shoes");
  final CollectionReference clockCollection = FirebaseFirestore.instance.collection("clocks");
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  Future<Item> getMyItem(noteId) async {
    DocumentSnapshot doc = await itemCollection.doc(uid).collection("my_items").doc(noteId).get();
    Item item = Item.fromMap(doc.data());
    return item;
  }

  Future<int> insertItemCart(Item item) async {
    DocumentReference ref = await itemCollection.doc(uid).collection("my_items").add({
      "name": item.name,
      "brand": item.brand,
      "code": item.code,
      "type": item.type,
      "price": item.price,
      "image": item.image,
    });
    return 42;
  }

  Future<int> insertUser(CompleteForm completeForm) async {
    DocumentReference ref = await userCollection.add({
      "name": completeForm.name,
      "emailAdress": completeForm.emailAddress,
      "password": completeForm.password,
      "phone": completeForm.phone,
      "address": completeForm.address,
      "radioButtonGender": completeForm.radioButtonGender,
    });
    return 42;
  }

  Future<int> deleteItem(noteId) async {
    await itemCollection.doc(uid).collection("my_items").doc(noteId).delete();
    return 42;
  }

  ItemCollection _itemListFromSnapshot(QuerySnapshot snapshot) {
    ItemCollection itemCollection = ItemCollection();
    for (var doc in snapshot.docs) {
      Item item = Item.fromMap(doc.data());
      itemCollection.insertNoteOfId(doc.id, item);
    }
    return itemCollection;
  }

  Future<ItemCollection> getItemList() async {
    QuerySnapshot snapshot = await itemCollection.doc(uid).collection("my_items").get();

    return _itemListFromSnapshot(snapshot);
  }

  Future<ItemCollection> getShoesList() async {
    QuerySnapshot snapshot = await shoeCollection.doc("Tct4opOCsZw7IBhr091Y").collection("all_shoes").get();

    return _itemListFromSnapshot(snapshot);
  }

  Future<ItemCollection> getClocksList() async {
    QuerySnapshot snapshot = await clockCollection.doc("GGzmuBnF1pJNzMUbdBJg").collection("all_clocks").get();

    return _itemListFromSnapshot(snapshot);
  }

  Stream get stream {
    return itemCollection.doc(uid).collection("my_items").snapshots().map(_itemListFromSnapshot);
  }

  Stream get shoesStream {
    return shoeCollection.doc("Tct4opOCsZw7IBhr091Y").collection("all_shoes").snapshots().map(_itemListFromSnapshot);
  }

  Stream get clocksStream {
    return clockCollection.doc("GGzmuBnF1pJNzMUbdBJg").collection("all_clocks").snapshots().map(_itemListFromSnapshot);
  }
}
