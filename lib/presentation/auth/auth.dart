import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/data/repository/auth_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';
import 'package:nike_store_flutter/gen/assets.gen.dart';
import 'package:nike_store_flutter/presentation/auth/bloc/auth_bloc.dart';
import 'package:nike_store_flutter/presentation/theme/my_theme.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

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
      return AppPreferences.locale.value.languageCode == 'en'
          ? '$fieldName is required'
          : '$fieldName نمیتواند خالی باشد';
    }

    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppPreferences.locale.value.languageCode == 'en'
          ? 'Email is required'
          : 'آدرس ایمیل نمی‌تواند خالی باشد';
    }
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppPreferences.locale.value.languageCode == 'en'
          ? 'Enter a valid email address'
          : 'آدرس ایمیل معتبر نیست';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppPreferences.locale.value.languageCode == 'en'
          ? 'Please confirm your password'
          : 'تکرار رمز عبور نمی‌تواند خالی باشد';
    }
    if (value != _passwordController.text) {
      return AppPreferences.locale.value.languageCode == 'en'
          ? 'Passwords do not match'
          : 'رمز عبور و تکرار آن یکسان نیستند';
    }
    return null;
  }

  Future<void> _onSubmit(bool isInLogin, BuildContext context) async {
    // اول اعتبارسنجی فرم
    if (!_formKey.currentState!.validate()) {
      return;
    }
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppPreferences.locale.value.languageCode == 'en' ? 'Error' : 'خطا'}: $e',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final en = AppPreferences.locale.value.languageCode == 'en';
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeData = Theme.of(context);
    return Directionality(
      textDirection: en ? TextDirection.ltr : TextDirection.rtl,
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
              return AuthBloc(repository: authRepository)
                ..add(AuthInitialEvent());
            },
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) Navigator.of(context).pop();
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        en
                            ? state.exception.messageEn
                            : state.exception.messageFa,
                      ),
                    ),
                  );
                }
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
                                  ? (en
                                        ? 'Welcome to Nike Store'
                                        : 'به نایک استور خوش آمدید')
                                  : (en ? 'Create account' : 'ثبت نام'),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 8),

                            Text(
                              state.isLoginMode
                                  ? (en
                                        ? 'Sign in or create an account'
                                        : 'لطفا وارد حساب کاربری خود شوید، یا ثبت نام کنید')
                                  : (en
                                        ? 'Please complete the required information'
                                        : 'لطفا اطلاعات خواسته شده را تکمیل کنید'),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 30),

                            if (!state.isLoginMode) ...[
                              TextFormField(
                                controller: _fullnameController,
                                keyboardType: TextInputType.text,
                                validator: (value) => _requiredValidator(
                                  value,
                                  en ? 'Full name' : 'نام و نام خانوادگی',
                                ),

                                decoration: InputDecoration(
                                  label: Text(
                                    en ? 'Full name' : 'نام و نام خانوادگی',
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                label: Text(
                                  en ? 'Email address' : 'آدرس ایمیل',
                                ),
                              ),
                              validator: _emailValidator,
                            ),
                            SizedBox(height: 16),
                            _PasswordTextFIeld(
                              label: en ? 'Password' : 'رمز عبور',
                              passwordController: _passwordController,
                              validator: _confirmPasswordValidator,
                            ),

                            if (!state.isLoginMode) ...[
                              SizedBox(height: 16),
                              _PasswordTextFIeld(
                                label: en
                                    ? 'Confirm password'
                                    : 'تکرار رمز عبور',
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
                                  : Text(
                                      state.isLoginMode
                                          ? (en ? 'Sign in' : 'ورود')
                                          : (en ? 'Sign up' : 'ثبت نام'),
                                    ),
                            ),
                            SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.isLoginMode
                                      ? (en
                                            ? "Don't have an account?"
                                            : 'حساب کاربری ندارید؟ ')
                                      : (en
                                            ? 'Already have an account?'
                                            : 'حساب کاربری دارید؟'),
                                ),
                                SizedBox(width: 12),

                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<AuthBloc>(
                                      context,
                                    ).add(AuthModeChangeIsClickedEvent());
                                  },
                                  child: Text(
                                    state.isLoginMode
                                        ? (en ? 'Sign up' : 'ثبت نام')
                                        : (en ? 'Sign in' : 'ورود'),
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
      ),
    );
  }
}

class _PasswordTextFIeld extends StatefulWidget {
  final String label;
  final TextEditingController _passwordController;
  final String? Function(String?)? validator;

  const _PasswordTextFIeld({
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
