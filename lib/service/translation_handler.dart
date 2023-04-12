import 'package:translator/service/api.dart';

class TranslationHandler {
  static TranslationHandler? _instance;
  static TranslationHandler get instance {
    _instance ??= TranslationHandler._internal();
    return _instance!;
  }

  TranslationHandler._internal();

  final Api _apiHandler = Api();

  Future<String> translate(String text, String from, String to) async {
    if (text.isEmpty) {
      return "";
    }
    String translatedText = await _apiHandler.getTranslation(text, from, to);
    
    return translatedText;
  }

  Future<List<String>> getLanguages() async {
    List<String> codeList = await _apiHandler.getLanguages();
    
    return codeList;
  }
  Future<String> getDetection(String text) async {
    String code = await _apiHandler.getDetection(text);
    return code;
  }

}
