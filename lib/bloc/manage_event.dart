import '../model/item.dart';

abstract class ManageEvent {}

class SubmitEvent extends ManageEvent {
  Item item;
  SubmitEvent({required this.item});
}

class DeleteEvent extends ManageEvent {
  String itemId;
  DeleteEvent({required this.itemId});
}

class UpdateRequest extends ManageEvent {
  String itemId;
  Item previousItem;
  UpdateRequest({required this.itemId, required this.previousItem});
}

class UpdateCancel extends ManageEvent {}
