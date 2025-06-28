import 'package:flutter_tts/flutter_tts.dart';

class YTtsUtils {
  static final YTtsUtils _singleton = new YTtsUtils._internal();
  YTtsUtils._internal();

  factory YTtsUtils() {
    return _singleton;
  }
  static FlutterTts flutterTts = FlutterTts();

  static play(String speakLanguage, String voiceText) async {
    await flutterTts.setLanguage(speakLanguage);
    await flutterTts.speak(voiceText);
  }
}
