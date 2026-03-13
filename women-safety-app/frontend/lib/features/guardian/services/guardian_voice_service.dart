import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class GuardianVoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  Timer? _sequenceTimer;
  int _currentStep = 0;
  
  final List<Map<String, dynamic>> _script = [
    {
      "time": 0,
      "text": "Hey, it’s me. Just checking in to make sure you’re okay."
    },
    {
      "time": 8,
      "text": "Remember to stay aware of your surroundings. If you’re walking, keep your phone in your hand and avoid distractions."
    },
    {
      "time": 18,
      "text": "You’re doing great. If you ever feel uncomfortable, use the SOS button. I’ll get notified immediately."
    },
    {
      "time": 30,
      "text": "Try to stay in well-lit areas and around other people. If you need to, you can share your live location with me."
    },
    {
      "time": 42,
      "text": "You are strong and capable. Trust your instincts – if something feels wrong, it probably is."
    },
    {
      "time": 52,
      "text": "I’m here with you until you’re safe. Just a little longer and you’ll be home."
    },
    {
      "time": 60,
      "text": "I’ll check on you later. Stay safe, okay? Bye."
    },
  ];

  Future<bool> init() async {
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.45);
      await _flutterTts.setVolume(1.0);
      return true;
    } catch (e) {
      return false;
    }
  }

  void startVoiceGuidance({Function? onComplete}) {
    if (_isPlaying) return;
    _isPlaying = true;
    _currentStep = 0;
    _startNextStep(onComplete);
  }

  void _startNextStep(Function? onComplete) {
    if (!_isPlaying || _currentStep >= _script.length) {
      if (_currentStep >= _script.length) {
        _isPlaying = false;
        onComplete?.call();
      }
      return;
    }

    final step = _script[_currentStep];
    final delay = _currentStep == 0 
        ? 0 
        : step['time'] - _script[_currentStep - 1]['time'];

    _sequenceTimer = Timer(Duration(seconds: delay), () async {
      if (!_isPlaying) return;
      
      await _flutterTts.speak(step['text']);
      _currentStep++;
      _startNextStep(onComplete);
    });
  }

  Future<void> stop() async {
    _isPlaying = false;
    _sequenceTimer?.cancel();
    await _flutterTts.stop();
  }

  void dispose() {
    stop();
  }
}
