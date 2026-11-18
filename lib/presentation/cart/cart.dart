import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store_flutter/data/repository/auth_repository_impl.dart';
import 'package:nike_store_flutter/domain/models/auth_response/auth_response.dart';
import 'package:nike_store_flutter/presentation/auth/auth.dart';
import 'package:nike_store_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        AppPreferences.locale.value.languageCode == 'en'
            ? 'Shopping cart'
            : 'سبد خرید',
      ),
    ),
    body: ValueListenableBuilder<AuthResponse?>(
      valueListenable: AuthRepositoryImpl.authChangeNotifier,
      builder: (context, auth, _) {
        final en = AppPreferences.locale.value.languageCode == 'en';
        if (auth?.token?.isNotEmpty != true) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  en
                      ? 'Sign in to view your cart'
                      : 'برای دیدن سبد خرید وارد حساب شوید',
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                    rootNavigator: true,
                  ).push(MaterialPageRoute(builder: (_) => const AuthScreen())),
                  child: Text(en ? 'Sign in' : 'ورود به حساب کاربری'),
                ),
              ],
            ),
          );
        }
        return BlocProvider(
          create: (_) => CartBloc()..add(CartLoadRequested()),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading || state is CartInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CartFailure) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.message),
                      TextButton(
                        onPressed: () =>
                            context.read<CartBloc>().add(CartLoadRequested()),
                        child: Text(en ? 'Retry' : 'تلاش دوباره'),
                      ),
                    ],
                  ),
                );
              }
              final items = (state as CartLoaded).items;
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    en ? 'Your cart is empty' : 'سبد خرید شما خالی است',
                  ),
                );
              }
              final total = items.fold<int>(
                0,
                (sum, item) => sum + item.product.priceToman * item.quantity,
              );
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return ListTile(
                          leading: item.product.images.isEmpty
                              ? const Icon(Icons.shopping_bag_outlined)
                              : Image.network(
                                  item.product.images.first,
                                  width: 52,
                                  errorBuilder: (_, _, _) =>
                                      const Icon(Icons.shopping_bag_outlined),
                                ),
                          title: Text(item.product.title),
                          subtitle: Text(
                            '${item.product.priceToman} ${en ? 'Toman' : 'تومان'} · ${item.variant.color} · ${item.variant.size}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  CartItemDecreaseRequested(item.id),
                                ),
                                icon: const Icon(Icons.remove),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  CartItemIncreaseRequested(item.id),
                                ),
                                icon: const Icon(Icons.add),
                              ),
                              IconButton(
                                onPressed: () => context.read<CartBloc>().add(
                                  CartItemRemoveRequested(item.id),
                                ),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${en ? 'Total' : 'جمع کل'}: $total ${en ? 'Toman' : 'تومان'}',
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    ),
  );
}
