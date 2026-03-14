import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sss/core/providers/app_providers.dart';
import 'package:sss/core/services/auth_service.dart';
import 'package:sss/core/providers/signin_form_provider.dart';

/// Sign-in business logic: authenticate with email/password.
/// Throws [FirebaseAuthException] on failure; view handles navigation and error UI.
class SigninController {
  SigninController(this._authService);

  final AuthService _authService;

  /// Signs in with email and password.
  /// Call from view; on success view should navigate (e.g. to home/splash).
  Future<void> signIn(SigninFormState form) async {
    await _authService.signInWithEmail(
      email: form.email,
      password: form.password,
    );
  }
}

final signinControllerProvider = Provider<SigninController>((ref) {
  return SigninController(ref.read(authServiceProvider));
});
