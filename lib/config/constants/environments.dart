import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
}