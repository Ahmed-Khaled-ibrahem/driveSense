import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // if (_formKey.currentState!.validate()) {
    //   await ref
    //       .read(authProvider.notifier)
    //       .login(_emailController.text.trim(), _passwordController.text);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authProvider);

    // Navigate to home if authenticated
    // if (authState.user != null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     context.go('/');
    //   });
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('auth.login'.tr()),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'auth.welcome'.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'auth.email'.tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'auth.email_required'.tr();
                  }
                  if (!value.contains('@')) {
                    return 'auth.email_invalid'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'auth.password'.tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'auth.password_required'.tr();
                  }
                  if (value.length < 6) {
                    return 'auth.password_min_length'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              // if (authState.error != null)
              //   Container(
              //     padding: EdgeInsets.all(12),
              //     margin: EdgeInsets.only(bottom: 16),
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).colorScheme.errorContainer,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Text(
              //       authState.error!,
              //       style: TextStyle(
              //         color: Theme.of(context).colorScheme.onErrorContainer,
              //       ),
              //     ),
              //   ),
              // FilledButton(
              //   onPressed: authState.isLoading ? null : _login,
              //   child: authState.isLoading
              //       ? SizedBox(
              //           height: 20,
              //           width: 20,
              //           child: CircularProgressIndicator(strokeWidth: 2),
              //         )
              //       : Text('auth.login'.tr()),
              // ),
              SizedBox(height: 16),
              Text(
                'auth.demo_credentials'.tr(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Email: admin@example.com\nPassword: password',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
