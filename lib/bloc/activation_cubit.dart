import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/exceptions/license_exception.dart';
import 'package:olx_parser/repository/license_repository.dart';

abstract class ActivationState {}

class InValidKey extends ActivationState {}

class ActivationProgressBar extends ActivationState {}

class ActivationException extends ActivationState {
  final String message;

  ActivationException(this.message);
}

class ActivationForm extends ActivationState {}

class ValidActivationKey extends ActivationState {}

class ActivationCubit extends Cubit<ActivationState> {

  final LicenseRepository licenseRepository;

  ActivationCubit(this.licenseRepository) : super(ActivationProgressBar());

  void activate(String productKey) async {
    try {
      emit(ActivationProgressBar());

      final bool isValid = await licenseRepository.activateKey(productKey);

      if (isValid) {
        emit(ValidActivationKey());
      }
    } on LicenseKeyActivatedException {
      emit(InValidKey());
    } on InValidLicenseKeyException {
      emit(InValidKey());
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
