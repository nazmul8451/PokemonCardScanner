import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/core/constants/app_colors.dart';
import 'package:untitled2/core/routes/app_routes.dart';
import 'package:untitled2/presentation/commonWidgets/app_premium_button.dart';
import 'package:untitled2/presentation/commonWidgets/auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool agreedToTerms = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                  // Assuming `img.png` is the golden T. Replace this with the exact file name if different.
                  Image.asset(
                    'assets/images/image.png',
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 24.w),
                ],
              ),
              SizedBox(height: 48.h),
              Center(
                child: Text(
                  'Sign Up For Savings',
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
                label: 'Full Name',
                hintText: 'John Doe',
                controller: fullNameController,
              ),
              SizedBox(height: 24.h),
              AuthTextField(
                label: 'Email Address',
                hintText: 'email@example.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),
              AuthTextField(
                label: 'Phone Number',
                hintText: '+1 (555) 000-0000',
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24.h),
              AuthTextField(
                label: 'Password',
                hintText: '••••••••',
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(height: 24.h),
              AuthTextField(
                label: 'Confirm New Password',
                hintText: '••••••••',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        agreedToTerms = !agreedToTerms;
                      });
                    },
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(4.r),
                        color: agreedToTerms ? AppColors.primary : Colors.transparent,
                      ),
                      child: agreedToTerms
                          ? Icon(Icons.check, size: 16.sp, color: Colors.black)
                          : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        children: [
                          const TextSpan(
                            text: 'Terms and Conditions\nand Privacy Policy',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.h),
              AppPremiumButton(
                label: 'Sign Up',
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
                    Navigator.pop(context); // Go back to Sign In
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Login',
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
                    child: Text('Or sign up with', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14.sp)),
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