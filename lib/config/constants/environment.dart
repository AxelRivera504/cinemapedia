import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String movidDBKey = dotenv.env['MOVIEDB_KEY'] ??  'No hay api key';
}