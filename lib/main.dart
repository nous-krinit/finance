import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/app/app.bottomsheets.dart';
import 'package:my_finance/app/app.dialogs.dart';
import 'package:my_finance/app/app.locator.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/app_text_styles.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(TextStyles.navigationBar),
          indicatorColor: tertiaryColor,
          iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: tertiaryColor);
            }
            return IconThemeData(color: greyColor);
          }),
        ),
      ),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
