import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/dictionary_model.dart';

class DictonaryServices {
  static Future<List<Definition>> fetchDefintiion(
      {required String word}) async {
    final url =
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
    try {
      final response = await http.get(url);
      final responseData = response.body;
      final data = json.decode(responseData);
      final defData = (data[0]["meanings"][0]["definitions"] as List);
      final definition = List<Definition>.from(
          defData.map((definition) => Definition.fromJson(definition)));
      print(definition[0].definition);
      return definition;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
