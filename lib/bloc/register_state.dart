abstract class RegisterState {}

class InsertState extends RegisterState {}

class UpdateState extends RegisterState {
  String formId;
  UpdateState({required this.formId});
}
