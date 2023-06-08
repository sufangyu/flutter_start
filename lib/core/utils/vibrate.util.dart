import 'package:vibration/vibration.dart';

class VibrateUtil {
  static normal({int duration = 500}) async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: duration);
    }
  }

  static light({int duration = 10}) {
    normal(duration: duration);
  }

  static custom({
    int duration = 500,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(
        duration: duration,
        pattern: pattern,
        repeat: repeat,
        intensities: intensities,
        amplitude: amplitude,
      );
    }
  }
}
