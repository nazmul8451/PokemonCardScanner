import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/constants/app_colors.dart';
import 'package:untitled2/core/routes/app_routes.dart';
import 'package:untitled2/presentation/commonWidgets/app_premium_button.dart';
import 'package:untitled2/presentation/commonWidgets/auth_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Assuming `img.png` is the golden T. Replace this with the exact file name if different.
                  Image.asset(
                    'assets/images/image.png',
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(height: 48.h),
              Center(
                child: Text(
                  'Log In',
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
                  'Start saving with your friends and family.',
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
              SizedBox(height: 24.h),
              AuthTextField(
                label: 'Password',
                hintText: '••••••••',
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.resetPasswordRoute);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              AppPremiumButton(
                label: 'Log In',
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashboardRoute,
                    (route) => false,
                  );
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.signUpRoute);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.2), thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text('Or log in with', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14.sp)),
                  ),
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.2), thickness: 1)),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialBtn(
                    icon: Icons.apple,
                    label: 'Apple',
                    onTap: () {},
                  ),
                  SizedBox(width: 16.w),
                  _buildSocialBtn(
                    icon: Icons.g_mobiledata_rounded,
                    label: 'Google',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtn({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}