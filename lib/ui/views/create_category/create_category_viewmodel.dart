import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/ui/views/create_category/create_category_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../services/database_service.dart';

class CreateCategoryViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _databaseService = locator<DatabaseService>();

  Color selectedColor = Colors.red;
  Icon selectedIcon = Icon(Icons.shopping_cart);

  Future<void> showBottomSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.color,
    );

    if (result != null) {
      selectedColor = result.data;
      notifyListeners();
    }
  }

  Future<void> showIconSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.icon,
    );

    if (result != null) {
      selectedIcon = Icon(result.data);
      notifyListeners();
    }
  }

  Future<void> createCategory() async {
    final category = TxCategory(
      name: categoryValue ?? "Generic",
      icon: selectedIcon.icon!.codePoint.toRadixString(16).toUpperCase(),
      color: selectedColor.toARGB32(),
    );
    await _databaseService.addCategory(category);
    await _databaseService.getCategories();
    _navigationService.replaceWithCategoriesView();
  }
}
