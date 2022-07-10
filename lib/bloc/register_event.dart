import '../model/complete_form.dart';

abstract class RegisterEvent {}

class SubmitEvent extends RegisterEvent {
  CompleteForm completeForm;
  SubmitEvent({required this.completeForm});
}
