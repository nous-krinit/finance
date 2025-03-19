import 'package:my_finance/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_finance/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_finance/ui/views/home/home_view.dart';
import 'package:my_finance/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_finance/ui/views/create_transaction/create_transaction_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(
        page: HomeView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
    CustomRoute(
        page: StartupView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200),
    CustomRoute(
        page: CreateTransactionView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
