import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/repository/license_repository.dart';

import 'activation_cubit_state.dart';

class ActivationCubit extends Cubit<ActivationState> {
  final LicenseRepository licenseRepository;

  ActivationCubit(this.licenseRepository) : super(ActivationForm());

  void activateLicenseKey(String productKey) async {
    try {
      emit(ActivationProgressBar());

      final bool isValid = await licenseRepository.activateKey(productKey);

      if (isValid) {
        emit(ValidActivationKey());
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
