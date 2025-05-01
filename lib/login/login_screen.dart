import 'package:clipcut/login/widget/email_input_widget.dart';
import 'package:clipcut/login/widget/password_input_widget.dart';
import 'package:clipcut/login/widget/submit_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dependency_injection/locator.dart';
import 'login_bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  late LoginBloc _loginBlocs;

  @override
  void initState() {
    super.initState();
    _loginBlocs = LoginBloc(authApiRepository: getIt());
    _emailFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _loginBlocs.close();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _rememberMe,
          checkColor: Colors.white,
          activeColor: Color(0xffFAB112),
          onChanged: (value) {
            setState(() {
              _rememberMe = value!;
            });
          },
        ),
        Text(
          'Remember me',
          style: TextStyle(
            fontFamily: "Raleway",
            color: Color(0xff100F0F),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _topImageView(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.32,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/login_top.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 110),
              child: Center(child: Image.asset('images/logo_login.png')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontFamily: "Raleway",
            color: Color(0xff8B8B8B),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: Color(0xff8B8B8B),
            fontFamily: "Raleway",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xff100F0F),
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _topImageView(size),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Welcome Back!",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "Hello there. Sign in to continue",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w500,
                                color: Color(0xff7C7C7C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            BlocProvider(
                              create: (_) => _loginBlocs,
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      const EmailInputWidget(),
                                      const SizedBox(height: 20),
                                       PasswordInputWidget(),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildRememberMeCheckbox(),
                                          _buildForgotPasswordBtn(),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      SignInBtn(formKey: _formKey),
                                    ],
                                  ),
                                ),
                              ),
                            ), // Widget for email input field
                            const SizedBox(
                              height: 20,
                            ), // Widget for password input field
                            const Spacer(), // Push Sign Up to bottom
                            const SizedBox(height: 16),
                            _buildSignupBtnRow(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
