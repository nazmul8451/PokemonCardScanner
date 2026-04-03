import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/constants/app_colors.dart';
import 'package:untitled2/core/routes/app_routes.dart';
import 'package:untitled2/presentation/commonWidgets/app_premium_button.dart';
import 'package:untitled2/presentation/commonWidgets/auth_text_field.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                  ),
                  Image.asset('assets/images/image.png', width: 40.w, height: 40.w, fit: BoxFit.contain),
                  SizedBox(width: 24.w),
                ],
              ),
              SizedBox(height: 48.h),
              Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Enter your email address for reset password',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              AuthTextField(
                label: 'Email Address',
                hintText: 'email@example.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 48.h),
              AppPremiumButton(
                label: 'Send Reset Link',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.otpRoute);
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 16.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}