//// Data Provider para o banco de dados local sqflite
import 'package:dio/dio.dart';

import '../model/complete_form.dart';

class RestServer {
  // Atributo que irá afunilar todas as consultas
  static RestServer helper = RestServer._createInstance();

  // Construtor privado
  RestServer._createInstance();

  final Dio _dio = Dio();

  String prefixUrl = "https://si700-calciostore-default-rtdb.firebaseio.com/";
  String suffixUrl = "/.json";

  Future<int> insertCompleteForm(CompleteForm completeForm) async {
    Response response = await _dio.post(
      prefixUrl + suffixUrl,
      data: completeForm.toMap(),
    );
    return 42;
  }
}
