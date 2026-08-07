class Product {
  final int id;
  final String category;
  final String title;
  final String description;
  final double priceUsd;
  final int priceToman;
  final double? previousPriceUsd;
  final int? previousPriceToman;
  final double? discountPercentage;
  final List<String> images;
  final List<Variant> variants;

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.priceUsd,
    required this.priceToman,
    this.previousPriceUsd,
    this.previousPriceToman,
    this.discountPercentage,
    required this.images,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priceUsd: (json['price_usd'] as num).toDouble(),
      priceToman: json['price_toman'] as int,
      previousPriceUsd: (json['previous_price_usd'] as num?)?.toDouble(),
      previousPriceToman: json['previous_price_toman'] as int?,
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
      images: List<String>.from(json['images'] as List),
      variants: (json['variants'] as List)
          .map((v) => Variant.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'title': title,
    'description': description,
    'price_usd': priceUsd,
    'price_toman': priceToman,
    'previous_price_usd': previousPriceUsd,
    'previous_price_toman': previousPriceToman,
    'discount_percentage': discountPercentage,
    'images': images,
    'variants': variants.map((v) => v.toJson()).toList(),
  };
}

class Variant {
  final int id;
  final String color;
  final String size;
  final int stock;

  Variant({
    required this.id,
    required this.color,
    required this.size,
    required this.stock,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'] as int,
      color: json['color'] as String,
      size: json['size'] as String,
      stock: json['stock'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'color': color,
    'size': size,
    'stock': stock,
  };
}

class ProductSort {
  static const String priceAsc = 'price_asc';
  static const String priceDesc = 'price_desc';
  static const String newest = 'newest';
  static const String popular = 'popular';
}
