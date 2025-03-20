import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class IconSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  void onIconSelected(IconData icon) {
    _bottomSheetService.completeSheet(SheetResponse(data: icon));
  }
}
