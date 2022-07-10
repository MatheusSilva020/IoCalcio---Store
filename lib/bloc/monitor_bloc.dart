import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/items.dart';
import '../provider/firebase_firestore.dart';
import 'monitor_event.dart';
import 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  ItemCollection itemCollection = ItemCollection();

  MonitorBloc() : super(MonitorState(itemCollection: ItemCollection())) {
    FirestoreServer.helper.stream.listen((event) {
      itemCollection = event;
      add(UpdateList());
    });

    on<AskNewList>((event, emit) async {
      itemCollection = await FirestoreServer.helper.getItemList();
      emit(MonitorState(itemCollection: itemCollection));
    });

    on<UpdateList>((event, emit) {
      emit(MonitorState(itemCollection: itemCollection));
    });

    add(AskNewList());
  }
}
