class AddToCartRequestDto {
  int? productId;
  int? variantId;

  AddToCartRequestDto({this.productId, this.variantId});

  factory AddToCartRequestDto.fromJson(Map<String, dynamic> json) {
    return AddToCartRequestDto(
      productId: json['product_id'] as int?,
      variantId: json['variant_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'variant_id': variantId,
  };
}
