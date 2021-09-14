import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/repository/interface/license_repository.dart';

abstract class ActivationState {}

class InValidaKey extends ActivationState {}

class ActivationProgressBar extends ActivationState {}

class ActivationException extends ActivationState {
  final String message;

  ActivationException(this.message);
}

class ActivationForm extends ActivationState {}

class ValidActivationKey extends ActivationState {}

class ActivationCubit extends Cubit<ActivationState> {
  LicenseRepository licenseRepository;

  ActivationCubit(this.licenseRepository) : super(ActivationProgressBar());

  void activate(String productKey) async {
    try {
      emit(ActivationProgressBar());
      await Future.delayed(Duration(seconds: 1));
      emit(InValidaKey());
      emit(ActivationForm());
    } catch (e) {
      emit(ActivationException(e.toString()));
    }
  }

  void checkLicense() async {
    try {
      emit(ActivationProgressBar());
      await licenseRepository.checkLicenseKey();
      emit(ActivationForm());
    } catch (e) {
      emit(ActivationException(e.toString()));
    }
  }
}
