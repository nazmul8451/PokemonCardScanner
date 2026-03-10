import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ScanController extends ChangeNotifier {
  int _scansRemaining = 2;
  bool _isScanning = false;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  String? _errorMessage;

  int get scansRemaining => _scansRemaining;
  bool get isScanning => _isScanning;
  CameraController? get cameraController => _cameraController;
  bool get isCameraInitialized => _isCameraInitialized;
  String? get errorMessage => _errorMessage;

  Future<void> initializeCamera() async {
    if (_isCameraInitialized) return;
    _errorMessage = null;
    notifyListeners();

    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        _errorMessage = 'No camera found on this device.';
        notifyListeners();
        return;
      }

      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      _isCameraInitialized = true;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Camera Error: ${e.toString()}';
      debugPrint('Error initializing camera: $e');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void startScanning() async {
    if (_scansRemaining > 0) {
      _isScanning = true;
      notifyListeners();

      // Mock scanning process
      await Future.delayed(const Duration(seconds: 2));

      _scansRemaining--;
      _isScanning = false;
      notifyListeners();
    }
  }

  void resetScans() {
    _scansRemaining = 2;
    notifyListeners();
  }
}
