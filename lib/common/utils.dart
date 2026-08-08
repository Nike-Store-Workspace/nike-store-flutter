import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
