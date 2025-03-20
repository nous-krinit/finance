import 'dart:ui';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class ColorSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  void onColorSelected(Color color) {
    _bottomSheetService.completeSheet(SheetResponse(data: color));
  }
}
