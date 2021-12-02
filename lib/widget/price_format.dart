import 'package:intl/intl.dart';

String formatPrice(int price) {
  return NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
      .format(price);
}
