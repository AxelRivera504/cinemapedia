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

  static String shortDate( DateTime date ) {    
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
}