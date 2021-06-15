import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:olx_parser/bloc/activation_cubit.dart';
import 'package:olx_parser/bloc/activation_cubit_state.dart';
import 'package:olx_parser/repository/license_repository.dart';
import 'package:olx_parser/ui/components/activation_key_form.dart';
import 'package:olx_parser/ui/components/base_progress_bar.dart';

class ActivationScreen extends StatefulWidget {
  static String routeName = "activation_screen";

  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final LicenseRepository _licenseRepository = LicenseRepositoryImpl();
  late ActivationCubit _activationCubit;

  @override
  void initState() {
    super.initState();

    _activationCubit = ActivationCubit(_licenseRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: _activationCubit,
        listener: (_, state) {
          if (state is ActivationException) {
            Get.showSnackbar(
              GetBar(
                message: "Ключ дұрыс емес",
                snackStyle: SnackStyle.FLOATING,
              ),
            );
          }

          if (state is ValidActivationKey) {
            // TODO("")
          }
        },
        builder: (_, state) {
          if (state is ActivationProgressBar) {
            return BaseProgressBar();
          }

          return ActivationKeyForm(
            onActivate: (String passedLicenseKey) =>
                _activationCubit.activateLicenseKey(passedLicenseKey),
          );
        },
      ),
    );
  }
}
