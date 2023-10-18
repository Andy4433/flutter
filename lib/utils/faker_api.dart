import 'dart:convert';
import 'api_models.dart';
import 'package:http/http.dart' as http;

///Classe que controla as requisições dos horários/agendas.
class FakerApi {
  ///Função para obter os horários disponíveis com base nos paramêtros obrigatórios.
  static Future<List<Data>> getData() async {
    String url ='';
      url = 'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json';
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
