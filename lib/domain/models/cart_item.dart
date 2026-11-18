class CartItem {
  final int id;
  final int quantity;
  final CartProduct product;
  final CartVariant variant;
  const CartItem({required this.id, required this.quantity, required this.product, required this.variant});
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: (json['id'] as num).toInt(), quantity: (json['quantity'] as num).toInt(),
    product: CartProduct.fromJson(json['product'] as Map<String, dynamic>),
    variant: CartVariant.fromJson(json['variant'] as Map<String, dynamic>));
}
class CartProduct {
  final String title; final int priceToman; final List<String> images;
  const CartProduct({required this.title, required this.priceToman, required this.images});
  factory CartProduct.fromJson(Map<String,dynamic> j) => CartProduct(title: j['title'] as String? ?? '', priceToman: (j['price_toman'] as num? ?? 0).toInt(), images: (j['images'] as List? ?? []).cast<String>());
}
class CartVariant {
  final String color; final String size;
  const CartVariant({required this.color, required this.size});
  factory CartVariant.fromJson(Map<String,dynamic> j) => CartVariant(color: j['color'] as String? ?? '', size: j['size'] as String? ?? '');
}
