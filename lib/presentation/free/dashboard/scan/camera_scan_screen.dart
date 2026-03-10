import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import '../../../../controller/free/scan_controller.dart';
import '../../../commonWidgets/common_widgets.dart';

class CameraScanScreen extends StatefulWidget {
  const CameraScanScreen({super.key});

  @override
  State<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  bool _showDialog = true;
  bool _doNotShowAgain = false;

  @override
  void initState() {
    super.initState();
    // Initialize camera on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScanController>().initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanController = context.watch<ScanController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // ── Background / Real Camera Preview ──────────────────────────────
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child:
                  scanController.isCameraInitialized &&
                      scanController.cameraController != null
                  ? CameraPreview(scanController.cameraController!)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (scanController.errorMessage != null) ...[
                            const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 48,
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Text(
                                scanController.errorMessage!,
                                style: const TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            AppPremiumButton(
                              onTap: () => scanController.initializeCamera(),
                              label: 'Retry',
                              width: 120.w,
                              height: 40.h,
                            ),
                          ] else ...[
                            const CircularProgressIndicator(
                              color: Color(0xFFFFD700),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Initializing Camera...',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
          ),

          // ── Top Action Bar ───────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),
                  Text(
                    'ANALYZING',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Scanning Frame ────────────────────────────────────────────────
          Center(
            child: SizedBox(
              width: 300.w,
              height: 380.h,
              child: Stack(
                children: [
                  // Corner Borders
                  _buildCorner(Alignment.topLeft, 0, 0),
                  _buildCorner(Alignment.topRight, 90, 0),
                  _buildCorner(Alignment.bottomLeft, 270, 0),
                  _buildCorner(Alignment.bottomRight, 180, 0),
                ],
              ),
            ),
          ),

          // ── Ready to Scan Dialog ─────────────────────────────────────────
          if (_showDialog) _buildInstructionDialog(),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment, double rotateAngle, double dash) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: rotateAngle * 3.14159 / 180,
        child: Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: const Color(0xFFFFD700), width: 4.w),
              left: BorderSide(color: const Color(0xFFFFD700), width: 4.w),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionDialog() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w),
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              color: const Color(0xFF15181D),
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ready to scan?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15.sp,
                      height: 1.5,
                      fontFamily: 'Inter',
                    ),
                    children: const [
                      TextSpan(text: 'Place the card preferably on a '),
                      TextSpan(
                        text: 'black background',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' for the best condition analysis.'),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () =>
                      setState(() => _doNotShowAgain = !_doNotShowAgain),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _doNotShowAgain
                            ? Icons.check_box_rounded
                            : Icons.close_rounded,
                        color: _doNotShowAgain
                            ? const Color(0xFFFFD700)
                            : Colors.white.withOpacity(0.4),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Do not show again',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () => setState(() => _showDialog = false),
                  child: Text(
                    "Got it, let's go!",
                    style: TextStyle(
                      color: const Color(0xFF2A2D3E),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
