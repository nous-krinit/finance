import 'package:my_finance/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_finance/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_finance/ui/views/home/home_view.dart';
import 'package:my_finance/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_finance/ui/views/create_transaction/create_transaction_view.dart';
import 'package:my_finance/services/database_service.dart';
import 'package:my_finance/ui/bottom_sheets/categories/categories_sheet.dart';
import 'package:my_finance/ui/dialogs/delete/delete_dialog.dart';
import 'package:my_finance/ui/views/edit_transaction/edit_transaction_view.dart';
import 'package:my_finance/ui/views/stats/stats_view.dart';
import 'package:my_finance/ui/views/categories/categories_view.dart';
import 'package:my_finance/ui/views/create_category/create_category_view.dart';
import 'package:my_finance/ui/views/edit_category/edit_category_view.dart';
import 'package:my_finance/ui/bottom_sheets/color/color_sheet.dart';
import 'package:my_finance/ui/bottom_sheets/icon/icon_sheet.dart';
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
    CustomRoute(
        page: EditTransactionView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
    CustomRoute(
        page: StatsView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
    CustomRoute(
        page: CategoriesView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
    CustomRoute(
        page: CreateCategoryView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
    CustomRoute(
        page: EditCategoryView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 500),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: CategoriesSheet),
    StackedBottomsheet(classType: ColorSheet),
    StackedBottomsheet(classType: IconSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: DeleteDialog),
// @stacked-dialog
  ],
)
class App {}
