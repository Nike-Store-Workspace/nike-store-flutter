class User {
  int? id;
  String? email;
  String? fullName;
  DateTime? createdAt;

  User({this.id, this.email, this.fullName, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    email: json['email'] as String?,
    fullName: json['full_name'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'full_name': fullName,
    'created_at': createdAt?.toIso8601String(),
  };
}
