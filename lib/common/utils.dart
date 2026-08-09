import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLabel on String {
  String get withTomanPriceLabel => "$this تومان";
  String get withUsdPriceLabel => "$this USD";
}

extension PriceFormatter on num {
  // اعداد فارسی + ویرگول فارسی (مثال: ۱,۲۵۰,۰۰۰)
  String get toPersianPrice {
    return NumberFormat('#,###', 'fa_IR').format(this).withTomanPriceLabel;
  }

  // اعداد انگلیسی + ویرگول (مثال: 1,250,000)
  String get toEnglishPrice {
    return NumberFormat('#,###').format(this).withUsdPriceLabel;
  }
}

extension DateFormatter on DateTime {
  String get toPersianDate {
    Jalali shamsiDate = Jalali.fromDateTime(this);
    // ۳. فرمت‌دهی متنی (مثال: ۱۵ اردیبهشت ۱۴۰۳)
    final formatter = shamsiDate.formatter;
    final date = '${formatter.d} ${formatter.mN} ${formatter.yyyy}';
    return date;
  }
}
