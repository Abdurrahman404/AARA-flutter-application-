import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final vm = context.read<AuthViewModel>();
    final success = await vm.login(_emailCtrl.text.trim(), _passCtrl.text);
    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

<<<<<<< HEAD
  Future<void> _googleLogin() async {
    final vm = context.read<AuthViewModel>();
    final success = await vm.loginWithGoogle();
    if (success && mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Text(
                    'AARA',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      letterSpacing: 8,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'fashion redefined',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppColors.accent,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
<<<<<<< HEAD
                Text('Welcome Back',
                    style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 8),
                Text('Sign in to continue',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 36),

                // Email field
=======
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 36),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                CustomTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  prefix: const Icon(Icons.email_outlined,
                      color: AppColors.textLight, size: 20),
<<<<<<< HEAD
                  validator: (v) => v!.isEmpty ? 'Enter your email' : null,
                ),
                const SizedBox(height: 20),

                // Password field
=======
                  validator: (v) =>
                      v!.isEmpty ? 'Enter your email' : null,
                ),
                const SizedBox(height: 20),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                CustomTextField(
                  label: 'Password',
                  hint: '••••••••',
                  controller: _passCtrl,
                  obscureText: !_showPassword,
                  prefix: const Icon(Icons.lock_outlined,
                      color: AppColors.textLight, size: 20),
                  suffix: IconButton(
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textLight,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                  validator: (v) =>
                      v!.length < 6 ? 'Minimum 6 characters' : null,
                ),
                const SizedBox(height: 12),
<<<<<<< HEAD

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => _showForgotPasswordDialog(context),
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Error message
                Consumer<AuthViewModel>(builder: (ctx, vm, _) {
                  if (vm.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.error, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(vm.errorMessage!,
                                style: const TextStyle(
                                    color: AppColors.error, fontSize: 13)),
                          ),
                        ]),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // Sign In button
=======
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 32),
                Consumer<AuthViewModel>(
                  builder: (ctx, vm, _) {
                    if (vm.errorMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline,
                                  color: AppColors.error, size: 18),
                              const SizedBox(width: 8),
                              Text(vm.errorMessage!,
                                  style: const TextStyle(
                                      color: AppColors.error, fontSize: 13)),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                Consumer<AuthViewModel>(
                  builder: (ctx, vm, _) => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: vm.isLoading ? null : _login,
                      child: vm.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
<<<<<<< HEAD
                                  color: Colors.white, strokeWidth: 2))
=======
                                  color: Colors.white, strokeWidth: 2),
                            )
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                          : const Text('Sign In'),
                    ),
                  ),
                ),
<<<<<<< HEAD

                const SizedBox(height: 20),

                // ── OR divider ──────────────────────────────────────────────
                Row(children: [
                  const Expanded(child: Divider(color: AppColors.divider)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('OR',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textLight)),
                  ),
                  const Expanded(child: Divider(color: AppColors.divider)),
                ]),

                const SizedBox(height: 20),

                // ── Google Sign-In button ────────────────────────────────────
                Consumer<AuthViewModel>(
                  builder: (ctx, vm, _) => SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: vm.isLoading ? null : _googleLogin,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.divider),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google 'G' icon using coloured text (no package needed)
                          const Text('G',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4285F4),
                              )),
                          const SizedBox(width: 10),
                          Text('Continue with Google',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.textDark)),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sign Up link
=======
                const SizedBox(height: 24),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium),
                    GestureDetector(
<<<<<<< HEAD
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
=======
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.register),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  void _showForgotPasswordDialog(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your email to receive a reset link.'),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final vm = context.read<AuthViewModel>();
              final ok = await vm.sendPasswordReset(ctrl.text.trim());
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(ok
                    ? 'Reset link sent! Check your inbox.'
                    : vm.errorMessage ?? 'Failed to send reset link.'),
                backgroundColor: ok ? AppColors.success : AppColors.error,
                behavior: SnackBarBehavior.floating,
              ));
            },
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
}
