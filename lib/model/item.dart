import 'package:firebase_storage/firebase_storage.dart';

class Item {
  String _name = "";
  String _brand = "";
  String _code = "";
  bool _type = false;
  double _price = 0.0;
  String image = "";

  //setters:
  void setName() {}

  void setBrand() {}

  void setType() {}

  void setCode() {}

  void setPrice() {}

  void setImage() {}

  //getters
  String get name => _name;
  String get brand => _brand;
  String get code => _code;
  bool get type => _type;
  double get price => _price;

  Item.withData({name = "", brand = "", code = "", type = false, price = 0.0, image = ""}) {
    _name = name;
    _brand = brand;
    _code = code;
    _type = type;
    _price = price;
    image = image;
  }

  Item.fromMap(map) {
    _name = map["name"];
    _brand = map["brand"];
    _code = map["code"];
    _type = map["type"] ?? false;
    _price = (map["price"]).toDouble();
    image = (map["image"]);
  }

  toMap() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["brand"] = _brand;
    map["code"] = _code;
    map["type"] = _type;
    map["price"] = _price;
    map["image"] = image;
    return map;
  }

  getImageURL(path) async {
    Reference ref = FirebaseStorage.instance.ref().child(path);
    image = (await ref.getDownloadURL()).toString();
  }
}
