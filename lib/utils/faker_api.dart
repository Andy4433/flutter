import 'dart:convert';
import 'api_models.dart';
import 'package:http/http.dart' as http;

///Classe que controla as requisições dos horários/agendas.
class FakerApi {
  ///Função para obter os horários disponíveis com base nos paramêtros obrigatórios.
  static Future<List<Data>> getData() async {
    String url ='';
      url = 'https://fakerapi.it/api/v1/persons?_quantity=100&_gender=male&_birthday_start=2021-11-25&_birthday_end=2021-12-31';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Data> list = parseSchedules(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Data> parseSchedules(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed["data"].map<Data>((json) => Data.fromJson(json)).toList();
  }
}
