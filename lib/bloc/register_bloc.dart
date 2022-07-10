import 'package:bloc/bloc.dart';
import '../provider/firebase_firestore.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InsertState()) {
    on<SubmitEvent>((event, emit) {
      if (state is InsertState) {
        FirestoreServer.helper.insertUser(event.completeForm);
      }
    });
  }
}
