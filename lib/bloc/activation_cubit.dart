import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/repository/license_repository.dart';
import 'package:olx_parser/repository/local_database_repository.dart';

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

      final bool isValid = await licenseRepository.activateKey(productKey);

      if (isValid) {
        emit(ValidActivationKey());
      } else {
        emit(InValidaKey());
      }
    } catch (e) {
      emit(ActivationException(e.toString()));
    }
  }

  void checkLicense() async {
    try {
      emit(ActivationProgressBar());

      final bool isValid = await licenseRepository.checkLicenseKey();

      if (isValid) {
        emit(ValidActivationKey());
      } else {
        emit(ActivationForm());
      }
    } catch (e) {
      emit(ActivationException(e.toString()));
    }
  }
}
