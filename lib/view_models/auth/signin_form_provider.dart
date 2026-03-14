import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sign-in form state (model) – Email + Password.
class SigninFormState {
  const SigninFormState({
    this.email = '',
    this.password = '',
    this.useEmailTab = true,
    this.obscurePassword = true,
  });

  final String email;
  final String password;
  final bool useEmailTab;
  final bool obscurePassword;

  bool get allRequiredFilled =>
      email.trim().isNotEmpty && password.trim().isNotEmpty;

  SigninFormState copyWith({
    String? email,
    String? password,
    bool? useEmailTab,
    bool? obscurePassword,
  }) {
    return SigninFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      useEmailTab: useEmailTab ?? this.useEmailTab,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

/// ViewModel for sign-in screen (MVVM).
class SigninFormNotifier extends StateNotifier<SigninFormState> {
  SigninFormNotifier() : super(const SigninFormState());

  void setEmail(String value) => state = state.copyWith(email: value);
  void setPassword(String value) => state = state.copyWith(password: value);
  void setUseEmailTab(bool value) => state = state.copyWith(useEmailTab: value);
  void toggleObscurePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);
}

final signinFormProvider =
    StateNotifierProvider<SigninFormNotifier, SigninFormState>((ref) {
  return SigninFormNotifier();
});
