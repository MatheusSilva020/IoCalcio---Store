import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/items.dart';
import '../provider/firebase_firestore.dart';
import 'monitor_shoes_event.dart';
import 'monitor_shoes_state.dart';

class MonitorShoesBloc extends Bloc<MonitorShoesEvent, MonitorShoesState> {
  ItemCollection itemCollection = ItemCollection();

  MonitorShoesBloc() : super(MonitorShoesState(itemCollection: ItemCollection())) {
    FirestoreServer.helper.shoesStream.listen((event) {
      itemCollection = event;
      add(UpdateList());
    });

    on<AskNewList>((event, emit) async {
      itemCollection = await FirestoreServer.helper.getShoesList();
      emit(MonitorShoesState(itemCollection: itemCollection));
    });

    on<UpdateList>((event, emit) {
      emit(MonitorShoesState(itemCollection: itemCollection));
    });

    add(AskNewList());
  }
}
