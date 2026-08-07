class NikeStoreBanner {
  final int id;
  final String name;
  final String address;

  NikeStoreBanner({
    required this.id,
    required this.name,
    required this.address,
  });

  factory NikeStoreBanner.fromJson(Map<String, dynamic> json) {
    return NikeStoreBanner(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'address': address};
}

enum BannerLang { fa, en }
