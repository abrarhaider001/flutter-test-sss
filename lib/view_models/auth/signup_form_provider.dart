import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Signup form state (model) for the Welcome screen.
class SignupFormState {
  const SignupFormState({
    this.email = '',
    this.username = '',
    this.birthday = '',
    this.password = '',
    this.useEmailTab = true,
    this.obscurePassword = true,
  });

  final String email;
  final String username;
  final String birthday;
  final String password;
  final bool useEmailTab;
  final bool obscurePassword;

  bool get allRequiredFilled =>
      email.trim().isNotEmpty &&
      username.trim().isNotEmpty &&
      birthday.trim().isNotEmpty &&
      password.trim().isNotEmpty;

  SignupFormState copyWith({
    String? email,
    String? username,
    String? birthday,
    String? password,
    bool? useEmailTab,
    bool? obscurePassword,
  }) {
    return SignupFormState(
      email: email ?? this.email,
      username: username ?? this.username,
      birthday: birthday ?? this.birthday,
      password: password ?? this.password,
      useEmailTab: useEmailTab ?? this.useEmailTab,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

/// ViewModel for signup screen (MVVM).
class SignupFormNotifier extends StateNotifier<SignupFormState> {
  SignupFormNotifier() : super(const SignupFormState());

  void setEmail(String value) => state = state.copyWith(email: value);
  void setUsername(String value) => state = state.copyWith(username: value);
  void setBirthday(String value) => state = state.copyWith(birthday: value);
  void setPassword(String value) => state = state.copyWith(password: value);
  void setUseEmailTab(bool value) => state = state.copyWith(useEmailTab: value);
  void toggleObscurePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);
}

final signupFormProvider =
    StateNotifierProvider<SignupFormNotifier, SignupFormState>((ref) {
  return SignupFormNotifier();
});
