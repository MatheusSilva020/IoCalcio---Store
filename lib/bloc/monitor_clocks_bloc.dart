import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/items.dart';
import '../provider/firebase_firestore.dart';
import 'monitor_clocks_event.dart';
import 'monitor_clocks_state.dart';

class MonitorClocksBloc extends Bloc<MonitorClocksEvent, MonitorClocksState> {
  ItemCollection itemCollection = ItemCollection();

  MonitorClocksBloc() : super(MonitorClocksState(itemCollection: ItemCollection())) {
    FirestoreServer.helper.clocksStream.listen((event) {
      itemCollection = event;
      add(UpdateList());
    });

    on<AskNewList>((event, emit) async {
      itemCollection = await FirestoreServer.helper.getClocksList();
      emit(MonitorClocksState(itemCollection: itemCollection));
    });

    on<UpdateList>((event, emit) {
      emit(MonitorClocksState(itemCollection: itemCollection));
    });

    add(AskNewList());
  }
}
