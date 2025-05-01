import 'package:clipcut/utils/extensions/flush_bar_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/response/status.dart';
import '../../configs/routes/routes_name.dart';
import '../login_bloc/login_bloc.dart';

class SignInBtn extends StatelessWidget {
  final formKey;
  const SignInBtn({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(
      listenWhen:
          (current, previous) =>
              current.loginApi.status != previous.loginApi.status,
      listener: (context, state) {
        if (state.loginApi.status == Status.error) {
          context.showErrorSnackBar(
            state.loginApi.message.toString(),
          );
        }
        if (state.loginApi.status == Status.completed) {
          context.showSuccessSnackBar(
            state.loginApi.message.toString(),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.loginApi.status == Status.loading;

        return Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
              if (formKey.currentState.validate()) {
                context.read<LoginBloc>().add(const LoginApi());
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: const Color(0xff004961),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(53),
              ),
            ),
            child: isLoading
                ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
                : const Text(
              'SIGN IN',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Raleway",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}
