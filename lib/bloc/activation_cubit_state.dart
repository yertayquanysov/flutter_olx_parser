abstract class ActivationState {}

class InValidKey extends ActivationState {}

class ActivationProgressBar extends ActivationState {}

class ActivationForm extends ActivationState {}

class ValidActivationKey extends ActivationState {}

class ActivationException extends ActivationState {
  final String message;

  ActivationException(this.message);
}
