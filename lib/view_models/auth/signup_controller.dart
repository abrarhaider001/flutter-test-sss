import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sss/core/providers/app_providers.dart';
import 'package:sss/core/services/auth_service.dart';
import 'package:sss/core/providers/signup_form_provider.dart';

/// Signup business logic: create account and store user in Firestore.
/// Throws [FirebaseAuthException] on failure; view handles navigation and error UI.
class SignupController {
  SignupController(this._authService);

  final AuthService _authService;

  /// Creates account with email/password and saves user doc to Firestore.
  /// Call from view; on success view should navigate to signin.
  Future<void> signUp(SignupFormState form) async {
    await _authService.signUpWithEmail(
      email: form.email,
      password: form.password,
      username: form.username,
      birthday: form.birthday,
    );
  }
}

final signupControllerProvider = Provider<SignupController>((ref) {
  return SignupController(ref.read(authServiceProvider));
});
