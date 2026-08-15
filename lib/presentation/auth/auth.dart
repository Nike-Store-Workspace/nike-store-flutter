import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/data/repository/auth_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';
import 'package:nike_store_flutter/gen/assets.gen.dart';
import 'package:nike_store_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:nike_store_flutter/presentation/theme/MyTheme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName نمیتواند خالی باشد';
    }

    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'آدرس ایمیل نمی‌تواند خالی باشد';
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'آدرس ایمیل معتبر نیست';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'تکرار رمز عبور نمی‌تواند خالی باشد';
    }
    if (value != _passwordController.text) {
      return 'رمز عبور و تکرار آن یکسان نیستند';
    }
    return null;
  }

  Future<void> _onSubmit(bool isInLogin, BuildContext context) async {
    // اول اعتبارسنجی فرم
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Future.delayed(Duration(seconds: 2), () async {
      try {
        if (isInLogin) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoginButtonIsClickedEvent(
              request: LoginRequest(
                email: _emailController.text.trim(),
                password: _passwordController.text,
              ),
            ),
          );
        } else {
          BlocProvider.of<AuthBloc>(context).add(
            AuthSignUpButtonIsClickedEvent(
              request: SignupRequest(
                email: _emailController.text.trim(),
                password: _passwordController.text,
                fullName: _fullnameController.text.trim(),
                confirmPassword: _confirmPasswordController.text,
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('خطا: $e')));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size.fromHeight(56)),
              backgroundColor: WidgetStateProperty.all(
                themeData.colorScheme.onSurface,
              ),
              foregroundColor: WidgetStateProperty.all(
                isDarkMode ? MyTheme.darkBackgroundColor : Colors.white,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        child: Scaffold(
          body: BlocProvider<AuthBloc>(
            create: (context) {
              final bloc = AuthBloc(repository: authRepository);
              bloc.stream.forEach((state) {
                if (state is AuthSuccessState) {
                  Navigator.of(context).pop();
                } else if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception.messageFa)),
                  );
                }
              });
              bloc.add(AuthInitialEvent());
              return bloc;
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      current is AuthLoadingState ||
                      current is AuthInitialState ||
                      current is AuthErrorState,
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isDarkMode
                              ? Assets.img.nikeStorLogoDark.image(
                                  width: 130,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Assets.img.nikeStorLogoLite.image(
                                  width: 130,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                          SizedBox(height: 50),
                          Text(
                            state.isLoginMode
                                ? 'به نایک استور خوش آمدید'
                                : 'ثبت نام',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(height: 8),

                          Text(
                            state.isLoginMode
                                ? 'لطفا وارد حساب کاربری خود شوید، یا ثبت نام کنید'
                                : 'لطفا اطلاعات خواسته شده را تکمیل کنید',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 30),

                          if (!state.isLoginMode) ...[
                            TextFormField(
                              controller: _fullnameController,
                              keyboardType: TextInputType.text,
                              validator: (value) => _requiredValidator(
                                value,
                                'نام و نام خانوادگی',
                              ),

                              decoration: InputDecoration(
                                label: Text('نام و نام خانوادگی'),
                              ),
                            ),
                            SizedBox(height: 16),
                          ],

                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              label: Text('آدرس ایمیل'),
                            ),
                            validator: _emailValidator,
                          ),
                          SizedBox(height: 16),
                          _PasswordTextFIeld(
                            label: 'رمز عبور',
                            passwordController: _passwordController,
                            validator: _confirmPasswordValidator,
                          ),

                          if (!state.isLoginMode) ...[
                            SizedBox(height: 16),
                            _PasswordTextFIeld(
                              label: 'تکرار رمز عبور',
                              passwordController: _confirmPasswordController,
                              validator: _confirmPasswordValidator,
                            ),
                          ],
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: state is AuthLoadingState
                                ? null
                                : () => _onSubmit(state.isLoginMode, context),
                            child: state is AuthLoadingState
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(state.isLoginMode ? 'ورود' : 'ثبت نام'),
                          ),
                          SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.isLoginMode
                                    ? 'حساب کاربری ندارید؟ '
                                    : 'حساب کاربری دارید؟',
                              ),
                              SizedBox(width: 12),

                              InkWell(
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(
                                    context,
                                  ).add(AuthModeChangeIsClickedEvent());
                                },
                                child: Text(
                                  state.isLoginMode ? 'ثبت نام' : 'ورود',
                                  style: TextStyle(
                                    color: themeData.colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextFIeld extends StatefulWidget {
  final String label;
  final TextEditingController _passwordController;
  final String? Function(String?)? validator;

  const _PasswordTextFIeld({
    super.key,
    required this.label,
    required this._passwordController,
    this.validator,
  });

  @override
  State<_PasswordTextFIeld> createState() => _PasswordTextFIeldState();
}

class _PasswordTextFIeldState extends State<_PasswordTextFIeld> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        label: Text(widget.label),
      ),
    );
  }
}
