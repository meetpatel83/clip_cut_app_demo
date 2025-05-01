import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login_bloc/login_bloc.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  bool _hasError = false;
  bool _obscurePassword = true; // <-- Moved inside

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color fillColor = focusNode.hasFocus
        ? const Color(0xff00B4BF).withOpacity(0.1)
        : const Color(0xffd9d9d9).withOpacity(0.2);


    Color borderColor = _hasError
        ? Colors.red.withOpacity(0.1)
        : focusNode.hasFocus
        ? const Color(0xff00B4BF)
        : const Color(0xffb6bbbb);

    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (current, previous) => false,
      builder: (context, state) {
        return TextFormField(
          controller: passwordController,
          focusNode: focusNode,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            hintText: 'Password',
            hintStyle: const TextStyle(color: Colors.black),
            helperMaxLines: 2,
            errorMaxLines: 2,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xff00B4BF),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() => _hasError = true);
              return 'Enter password';
            }
            if (value.length < 6) {
              setState(() => _hasError = true);
              return 'Please enter password greater than 6 characters';
            }
            setState(() => _hasError = false);
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));

            final form = Form.of(context);
            if (form != null) {
              form.validate();
            }
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
