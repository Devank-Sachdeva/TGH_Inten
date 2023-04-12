// ignore_for_file: unused_field, avoid_print

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class Api {
  static const String _url =
      "https://google-translate1.p.rapidapi.com/language/translate/v2";

  static const Map<String, String> _headers = {
    "content-type": "application/x-www-form-urlencoded",
    "Accept-Encoding": "application/gzip",
    "X-RapidAPI-Key": "59587891b2msh5b6e64c7a5cb94ep1b39e3jsnf7136194d0a4",
    "X-RapidAPI-Host": "google-translate1.p.rapidapi.com"
  };

  final Dio _dio = Dio();

  Future<String> getTranslation(String text, String from, String to) async {
    try {
      final response = await _dio.post(
        _url,
        options: Options(
          headers: _headers,
        ),
        data: {
          "q": text,
          "source": from,
          "target": to,
        },
      );
      print("Translation response is ${response.data}");
      if (response.statusCode == 200) {
        String translatedText =
            response.data['data']['translations'][0]['translatedText'];
        print(translatedText);
        return (translatedText);
      } else {
        if (kDebugMode) {
          print("Request failed with status: ${response.statusCode}.");
        }
        return "";
      }
    } catch (e) {
      print(e);
      return "failure";
    }
  }

  Future<List<String>> getLanguages() async {
    try{ final response = await _dio.get(
      "$_url/languages",
      options: Options(headers: _headers),
    );

    if (response.statusCode == 200) {
      var data = response.data['data']['languages'] as List;
      List<String> codeList =
          List.generate(data.length, (index) => data[index]['language']);

      print(codeList);
      return codeList;
    } else {
      if (kDebugMode) {
        print("Request failed with status: ${response.statusCode}.");
      }
      return [];
    }}
    catch(e){
      print(e);
      return [];
    }
  }

  Future<String> getDetection(String text) async {
    try {
      final response = await _dio.post(
        "$_url/detect",
        options: Options(
          headers: _headers,
        ),
        data: {
          "q": text,
        },
      );
      
      if (response.statusCode == 200) {
        String detectedLanguage =
            response.data['data']['detections'][0][0]['language'];
        return (detectedLanguage);
        
      } else {
        if (kDebugMode) {
          print("Request failed with status: ${response.statusCode}.");
        }
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}
