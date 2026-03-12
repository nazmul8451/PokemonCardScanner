import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'controller/free/home_controller.dart';
import 'controller/free/markets_controller.dart';
import 'controller/free/scan_controller.dart';
import 'controller/subscription_controller.dart';
import 'core/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeController()),
            ChangeNotifierProvider(create: (_) => MarketsController()),
            ChangeNotifierProvider(create: (_) => ScanController()),
            ChangeNotifierProvider(create: (_) => SubscriptionController()),
          ],
          child: MaterialApp(
            title: 'Dashboard',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primary,
                secondary: AppColors.accent,
                surface: AppColors.surface,
              ),
              fontFamily: 'Inter',
              useMaterial3: true,
            ),
            initialRoute: AppRoutes.signInRoute,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
