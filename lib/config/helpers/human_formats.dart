import 'package:intl/intl.dart';

class HumanFormat{

  static String number( double numero, [int decimal = 0]){
      final formatterNumber = NumberFormat.compactCurrency(
        decimalDigits: decimal,
        symbol: '',
        locale: 'en'
      ).format(numero);

      return formatterNumber;
  }


}