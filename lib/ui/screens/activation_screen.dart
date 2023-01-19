import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olx_parser/bloc/activation_cubit.dart';
import 'package:olx_parser/repository/interface/license_repository.dart';
import 'package:olx_parser/repository/license_repository.dart';
import 'package:olx_parser/ui/components/activation/activation_key_form.dart';
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
    _activationCubit.checkLicense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Активация жасау"),
      ),
      body: BlocConsumer(
        bloc: _activationCubit,
        listener: (_, state) {
          if (state is InValidaKey) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text("Ключ дұрыс емес"),
                ),
              );
          }
        },
        builder: (_, state) {
          if (state is ActivationForm) {
            return ActivationKeyForm(
              licenseRepository: _licenseRepository,
              onActivate: (String passedLicenseKey) {
                _activationCubit.checkLicense();
              },
            );
          }

          return BaseProgressBar();
        },
      ),
    );
  }
}
