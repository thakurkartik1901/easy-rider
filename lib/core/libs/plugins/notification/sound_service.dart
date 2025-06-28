// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

enum VibrationPattern {
  startStop,
  continousStartStop,
}

class SoundService {
  SoundService._internal();

  static final AudioPlayer _audioPlayer = AudioPlayer();

  /// sound file should be in assets folder and path after assets to be provoed e.g. assets/audios/tap_sound.mp3
  static Future<void> playSound(
    String soundFile, {
    bool withVibration = false,
    int vibrationDuration = 500,
    int vibrationAmplitude = -1,
    double soundVolume = 1.0,
    VibrationPattern vibrationPattern = VibrationPattern.startStop,
  }) async {
    // await _audioPlayer.setAsset('assets/audios/tap_sound.mp3');
    await _audioPlayer.setVolume(soundVolume);
    await _audioPlayer.setAsset(soundFile);
    _audioPlayer.play();
    if (withVibration) {
      _playVibration(
          vibrationDuration: vibrationDuration,
          vibrationAmplitude: vibrationAmplitude,
          vibrationPattern: vibrationPattern);
    }
  }

  static Future<void> _playVibration({
    int vibrationDuration = 500,
    int vibrationAmplitude = -1,
    VibrationPattern vibrationPattern = VibrationPattern.startStop,
  }) async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      final hasAmplitudeControl = await Vibration.hasAmplitudeControl();
      if (hasAmplitudeControl != null && hasAmplitudeControl) {
        print("has Amplitude control");
        Vibration.vibrate(
          duration: vibrationDuration,
          amplitude: vibrationAmplitude,
          pattern: _getPatternType(vibrationPattern),
        );
      } else {
        print("No Amplitude control");
        Vibration.vibrate(
            duration: vibrationDuration,
            pattern: _getPatternType(vibrationPattern));
      }
    } else {
      print("No vibration capabilities");
    }
  }

  static List<int> _getPatternType(VibrationPattern vibrationPattern) {
    if (vibrationPattern == VibrationPattern.startStop) {
      return const [500, 1000, 500, 2000];
    } else if (vibrationPattern == VibrationPattern.continousStartStop) {
      return const [100, 500, 100, 500];
    } else {
      return const [];
    }
  }
}
