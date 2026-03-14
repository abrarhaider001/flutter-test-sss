import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sss/core/routes/app_routes.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';
import 'package:sss/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sss/core/widgets/labeled_icon_text_field.dart';
import 'package:sss/view_models/auth/signin_controller.dart';
import 'package:sss/core/providers/signin_form_provider.dart';

/// Sign-in screen: same UI design as signup (Email/Phone tabs, Email, Password).
/// MVVM: View only; state from [signinFormProvider] in view_models.
class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    final form = ref.watch(signinFormProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: MyColors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: MySizes.lg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: MySizes.xl),
              Text(
                'Welcome back!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: MyColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: MySizes.lg),
              Text(
                'Sign in with your email and password to continue.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: MyColors.textPrimary,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _TabLabel(
                      label: 'Email Address',
                      active: form.useEmailTab,
                      onTap:
                          () => ref
                              .read(signinFormProvider.notifier)
                              .setUseEmailTab(true),
                    ),
                    const SizedBox(width: MySizes.lg),
                    _TabLabel(
                      label: 'Phone Number',
                      active: !form.useEmailTab,
                      onTap:
                          () => ref
                              .read(signinFormProvider.notifier)
                              .setUseEmailTab(false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MySizes.md),
              LabeledIconTextField(
                hint: 'email@example.com',
                iconsaxIcon: Iconsax.sms,
                value: form.email,
                onChanged:
                    (v) => ref.read(signinFormProvider.notifier).setEmail(v),
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              LabeledIconTextField(
                hint: 'Password',
                iconsaxIcon: Iconsax.lock,
                value: form.password,
                obscureText: form.obscurePassword,
                onChanged:
                    (v) => ref.read(signinFormProvider.notifier).setPassword(v),
                suffixIcon: IconButton(
                  icon: Icon(
                    form.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color:
                        form.password.isEmpty
                            ? MyColors.iconSecondaryLight
                            : MyColors.primary,
                  ),
                  onPressed:
                      () =>
                          ref
                              .read(signinFormProvider.notifier)
                              .toggleObscurePassword(),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      form.allRequiredFilled
                          ? () => _handleSignin(context)
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        form.allRequiredFilled
                            ? MyColors.primary
                            : MyColors.buttonDisabled,
                    foregroundColor:
                        form.allRequiredFilled
                            ? MyColors.textWhite
                            : MyColors.buttonDisabledText,
                  ),
                  child: const Text('Sign in'),
                ),
              ),
              const SizedBox(height: MySizes.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: MyColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.signup),
                    child: Text(
                      'Signup',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: MyColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.xl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignin(BuildContext context) async {
    final form = ref.read(signinFormProvider);
    final controller = ref.read(signinControllerProvider);
    try {
      await controller.signIn(form);
      if (!context.mounted) return;
      context.go(AppRoutes.splash);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(MyFirebaseAuthException(e.code).message),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color:
                  active ? MyColors.textPrimary : MyColors.placeholderInactive,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 100,
            color: active ? MyColors.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
