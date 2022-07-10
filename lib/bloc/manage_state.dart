import '../model/item.dart';

abstract class ManageState {}

class InsertState extends ManageState {}

class UpdateState extends ManageState {
  String itemId;
  Item previousItem;
  UpdateState({required this.itemId, required this.previousItem});
}
