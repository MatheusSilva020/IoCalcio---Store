import '../provider/firebase_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'manage_event.dart';
import 'manage_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc() : super(InsertState()) {
    on<UpdateRequest>((event, emit) {
      emit(UpdateState(itemId: event.itemId, previousItem: event.previousItem));
    });

    on<UpdateCancel>((event, emit) {
      emit(InsertState());
    });

    on<SubmitEvent>((event, emit) {
      if (state is InsertState) {
        //ToDo: Inserir uma chamada de insert
        FirestoreServer.helper.insertItemCart(event.item);
      }
    });

    on<DeleteEvent>((event, emit) {
      // ToDo: Inserir uma chamada de Delete
      FirestoreServer.helper.deleteItem(event.itemId);
    });
  }
}
