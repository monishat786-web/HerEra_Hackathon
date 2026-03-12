import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class RecordingManager {
  final AudioRecorder _recorder = AudioRecorder();
  String? _recordedFilePath;

  // Check if currently recording
  Future<bool> isRecording() async => await _recorder.isRecording();

  // Get current amplitude stream
  Stream<Amplitude> onAmplitudeChanged(Duration interval) => _recorder.onAmplitudeChanged(interval);

  // Start recording
  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      // Get a safe directory
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${directory.path}/scream_$timestamp.m4a';

      // Configure recording (AAC format is widely supported)
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc, // good quality, small size
          bitRate: 64000,
          sampleRate: 16000,
        ),
        path: path,
      );
      _recordedFilePath = path;
    }
  }

  // Stop recording and return the file path
  Future<String?> stopRecording() async {
    if (!await _recorder.isRecording()) return null;
    final path = await _recorder.stop();
    return path;
  }

  // Dispose when done
  void dispose() {
    _recorder.dispose();
  }

  String? get lastRecordedFilePath => _recordedFilePath;
}
