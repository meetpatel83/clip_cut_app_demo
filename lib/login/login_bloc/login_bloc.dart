import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import '../../data/response/api_response.dart';
import '../../repository/auth_api/auth_api_repository.dart';
import '../../services/session_manager/session_controller.dart';
part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final AuthApiRepository authApiRepository;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription; // Nullable subscription

  LoginBloc({required this.authApiRepository}) : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);

    // Initialize the connectivity subscription
    _listenToConnectivityChanges();
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel(); // Cancel the subscription properly
    return super.close();
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onFormSubmitted(
      LoginApi event,
      Emitter<LoginStates> emit,
      ) async {
    // Reset the loginApi state before starting the login attempt
    emit(state.copyWith(loginApi: const ApiResponse.initial()));

    // Check internet connection
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = connectivityResult != ConnectivityResult.none;

    // If no internet, show error and return
    if (!isConnected) {
      emit(
        state.copyWith(
          loginApi: ApiResponse.error("No internet connection. Please check your network."),
        ),
      );
      return;
    }

    Map<String, String> data = {
      'email': state.email,
      'password': state.password,
      'device_id': '12345',
      'device_type': "android",
      'device_token': 'dhsbchsbhsadsaded',
    };

    emit(state.copyWith(loginApi: const ApiResponse.loading()));

    try {
      final value = await authApiRepository.loginApi(data);

      if (value.status != 200) {
        emit(
          state.copyWith(
            loginApi: ApiResponse.error(value.message.toString()),
          ),
        );
      } else {
        await SessionController().saveUserInPreference(value);
        await SessionController().getUserFromPreference();
        emit(
          state.copyWith(
            loginApi: ApiResponse.completedWithMessage(
              value.message,
              value.message,
            ),
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(loginApi: ApiResponse.error(error.toString())));
    }
  }

  // Listen to connectivity changes and trigger login attempt when connected
  void _listenToConnectivityChanges() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) async {
        // You can still handle connectivity changes here (e.g., for UI),
        // but do NOT auto-trigger login.
      },
    );
  }

}
