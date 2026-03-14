import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sss/core/routes/app_routes.dart';
import 'package:sss/core/utils/constants/colors.dart';
import 'package:sss/core/utils/constants/sizes.dart';
import 'package:sss/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sss/core/widgets/labeled_icon_text_field.dart';
import 'package:sss/view_models/auth/signup_controller.dart';
import 'package:sss/core/providers/signup_form_provider.dart';

/// Signup (Welcome) screen: Email/Phone tabs, E-mail, Username, Birthday, Password.
/// MVVM: View only; state from [signupFormProvider] in view_models.
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final form = ref.watch(signupFormProvider);
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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => context.go(AppRoutes.signin),
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: MyColors.textPrimary,
                  iconSize: 20,
                ),
              ),
              const SizedBox(height: MySizes.sm),
              Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: MyColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: MySizes.lg),
              Text.rich(
                TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: MyColors.textPrimary,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Please complete the required information, and then press the ',
                    ),
                    TextSpan(
                      text: 'Next',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: MyColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: ' button.'),
                  ],
                ),
                textAlign: TextAlign.center,
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
                              .read(signupFormProvider.notifier)
                              .setUseEmailTab(true),
                    ),
                    const SizedBox(width: MySizes.lg),
                    _TabLabel(
                      label: 'Phone Number',
                      active: !form.useEmailTab,
                      onTap:
                          () => ref
                              .read(signupFormProvider.notifier)
                              .setUseEmailTab(false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              LabeledIconTextField(
                hint: 'email@example.com',
                iconsaxIcon: Iconsax.sms,
                value: form.email,
                onChanged:
                    (v) => ref.read(signupFormProvider.notifier).setEmail(v),
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              LabeledIconTextField(
                hint: 'Username',
                iconsaxIcon: Iconsax.user,
                value: form.username,
                onChanged:
                    (v) => ref.read(signupFormProvider.notifier).setUsername(v),
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              LabeledIconTextField(
                hint: 'Birthday',
                iconsaxIcon: Iconsax.calendar,
                value: form.birthday,
                readOnly: true,
                onChanged: (_) {},
                onTap: () async {
                  final now = DateTime.now();
                  final initialDate =
                      form.birthday.trim().isEmpty
                          ? now
                          : _tryParseBirthday(form.birthday) ?? now;
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(now.year - 120, 1, 1),
                    lastDate: now,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: MyColors.primary,
                            onPrimary: MyColors.textWhite,
                            surface: MyColors.primaryBackground,
                            onSurface: MyColors.textPrimary,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    ref
                        .read(signupFormProvider.notifier)
                        .setBirthday(DateFormat.yMMMd().format(picked));
                  }
                },
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              LabeledIconTextField(
                hint: 'Password',
                iconsaxIcon: Iconsax.lock,
                value: form.password,
                obscureText: form.obscurePassword,
                onChanged:
                    (v) => ref.read(signupFormProvider.notifier).setPassword(v),
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
                              .read(signupFormProvider.notifier)
                              .toggleObscurePassword(),
                ),
              ),
              const SizedBox(height: MySizes.xs),
              Text(
                'Password must include a number, a letter, and a special character.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: MyColors.textPrimary,
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      form.allRequiredFilled
                          ? () => _handleSignup(context)
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
                  child: const Text('Next'),
                ),
              ),
              const SizedBox(height: MySizes.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: MyColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.signin),
                    child: Text(
                      'Signin',
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

  Future<void> _handleSignup(BuildContext context) async {
    final form = ref.read(signupFormProvider);
    final controller = ref.read(signupControllerProvider);
    try {
      await controller.signUp(form);
      if (!context.mounted) return;
      context.go(AppRoutes.signin);
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

DateTime? _tryParseBirthday(String value) {
  try {
    return DateFormat.yMMMd().parse(value);
  } catch (_) {
    return null;
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
