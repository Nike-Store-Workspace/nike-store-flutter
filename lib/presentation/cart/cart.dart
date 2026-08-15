import 'package:flutter/material.dart';
import 'package:nike_store_flutter/data/repository/auth_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/auth_response/auth_response.dart';
import 'package:nike_store_flutter/presentation/auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('سبد خرید')),
      body: ValueListenableBuilder<AuthResponse?>(
        valueListenable: AuthRepositoryImpl.authChangeNotifier,
        builder: (context, authState, child) {
          final bool isAuthenticated =
              authState != null && authState.token!.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isAuthenticated
                      ? 'خوش آمدید'
                      : 'لطفا وارد حساب کاربری خود شوید',
                ),
                SizedBox(height: 16),

                if (!isAuthenticated) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                      );
                      // Navigator.of(context, rootNavigator: true).push(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       authRepository.signOut();
                      //     },
                      //   ),
                      // );
                    },
                    child: Text('ورود به حساب کاربری'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      authRepository.signOut();
                    },
                    child: Text('خروج از حساب کاربری'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
