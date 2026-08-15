class ApiResponse<T> {
  final bool success;
  final String messageFa;
  final String messageEn;
  final T? data;

  ApiResponse({
    required this.success,
    this.data,
    required this.messageFa,
    required this.messageEn,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      messageFa: json['message_fa'] as String? ?? '',
      messageEn: json['message_en'] as String? ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'success': success,
      'message_fa': messageEn,
      'message_en': messageEn,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
