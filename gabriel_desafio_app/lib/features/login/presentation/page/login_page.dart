import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/mixins/mixin.dart';
import '../../../../core/utils/validation.dart';
import '../bloc/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageMixin, LoadingMixin {
  final _userEC = TextEditingController();
  final _passEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _obscurePass = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (message) {
                    showError(context, message);
                    hideLoading();
                  },
                  loading: () => showLoading(context),
                  success: () {
                    hideLoading();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LOCATIONS,
                      (route) => false,
                    );
                  },
                  orElse: () => hideLoading(),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    LOGO,
                    height: context.width * .25,
                  ),
                  const CustomSpace.sp1(),
                  Text(
                    'Bem-vindo',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const CustomSpace.sp1(),
                  const Text('Para começar, digite seu usuário e senha'),
                  const CustomSpace.sp4(),
                  CustomTextField(
                    controller: _userEC,
                    hintText: 'Usuário',
                    labelText: 'Usuário',
                    validators: [Required()],
                  ),
                  const CustomSpace.sp4(),
                  ValueListenableBuilder(
                    valueListenable: _obscurePass,
                    builder: (_, obscure, __) {
                      return CustomTextField(
                        controller: _passEC,
                        hintText: 'Senha',
                        labelText: 'Senha',
                        obscureText: obscure,
                        onPressViewPass: () {
                          _obscurePass.value = !obscure;
                        },
                        validators: [Required()],
                      );
                    },
                  ),
                  const CustomSpace(height: 40),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<LoginCubit>().login(
                              user: _userEC.text,
                              password: _passEC.text,
                            );
                      }
                    },
                    width: context.width * .5,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
