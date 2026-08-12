import 'package:flutter/material.dart';
import 'package:nike_store_flutter/gen/assets.gen.dart';
import 'package:nike_store_flutter/presentation/theme/MyTheme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isInLogin = true;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeData = Theme.of(context);
    return Theme(
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
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
                  isInLogin ? 'به نایک استور خوش آمدید' : 'ثبت نام',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 8),

                Text(
                  isInLogin
                      ? 'لطفا وارد حساب کاربری خود شوید، یا ثبت نام کنید'
                      : 'لطفا اطلاعات خواسته شده را تکمیل کنید',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 30),

                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(label: Text('آدرس ایمیل')),
                ),
                SizedBox(height: 16),
                _PasswordTextFIeld(),

                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(isInLogin ? 'ورود' : 'ثبت نام'),
                ),
                SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isInLogin ? 'حساب کاربری ندارید؟ ' : 'حساب کاربری دارید؟',
                    ),
                    SizedBox(width: 12),

                    InkWell(
                      onTap: () {
                        setState(() {
                          isInLogin = !isInLogin;
                        });
                      },
                      child: Text(
                        isInLogin ? 'ثبت نام' : 'ورود',
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
          ),
        ),
      ),
    );
  }
}

class _PasswordTextFIeld extends StatefulWidget {
  const _PasswordTextFIeld({super.key});

  @override
  State<_PasswordTextFIeld> createState() => _PasswordTextFIeldState();
}

class _PasswordTextFIeldState extends State<_PasswordTextFIeld> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
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
        label: Text('رمز عبور'),
      ),
    );
  }
}
