class CommentModel {
  final int? id;
  final int? productId;
  final int? userId;
  final String? userName;
  final String? titleEn;
  final String? titleFa;
  final String? body;
  final int? rating;
  final DateTime? createdAt;

  const CommentModel({
    this.id,
    this.productId,
    this.userId,
    this.userName,
    this.titleEn,
    this.titleFa,
    this.body,
    this.rating,
    this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      userId: json['user_id'] as int?,
      userName: json['user_name'] as String?,
      titleEn: json['title_en'] as String?,
      titleFa: json['title_fa'] as String?,
      body: json['body'] as String?,
      rating: json['rating'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'user_name': userName,
      'title_en': titleEn,
      'title_fa': titleFa,
      'body': body,
      'rating': rating,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  CommentModel copyWith({
    int? id,
    int? productId,
    int? userId,
    String? userName,
    String? titleEn,
    String? titleFa,
    String? body,
    int? rating,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      titleEn: titleEn ?? this.titleEn,
      titleFa: titleFa ?? this.titleFa,
      body: body ?? this.body,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
