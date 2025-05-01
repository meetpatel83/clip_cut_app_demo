import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login_bloc/login_bloc.dart';
import 'package:clipcut/utils/extensions/validations_exception.dart';

class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({super.key});

  @override
  State<EmailInputWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {}); // Update UI on focus change
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color fillColor = focusNode.hasFocus
        ? const Color(0xff00B4BF).withOpacity(0.1)
        : const Color(0xffd9d9d9).withOpacity(0.2);

    Color borderColor = focusNode.hasFocus
        ? const Color(0xff00B4BF)
        : const Color(0xffb6bbbb);

    return BlocBuilder<LoginBloc, LoginStates>(
      buildWhen: (current, previous) => false,
      builder: (context, state) {
        return TextFormField(
          controller: emailController,
          focusNode: focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.black),
            suffixIcon: const Icon(Icons.email, color: Color(0xff00B4BF)),
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
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          validator: (value) {
            if (value!.isEmpty) return 'Enter email';
            if (!value.emailValidator()) return 'Email is not correct';
            return null;
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
