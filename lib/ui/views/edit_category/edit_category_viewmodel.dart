import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/ui/views/create_category/create_category_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/category.dart';
import '../../../services/database_service.dart';

class EditCategoryViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _databaseService = locator<DatabaseService>();

  late int id;
  late String name;

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

  Future<void> editCategory(int? index) async {
    final category = TxCategory(
      id: index,
      name: categoryValue ?? "Generic",
      icon: selectedIcon.icon!.codePoint.toRadixString(16).toUpperCase(),
      color: selectedColor.toARGB32(),
    );
    await _databaseService.updateCategory(category);
    await _databaseService.getCategories();
    _navigationService.replaceWithCategoriesView();
  }

  void setInitialData(TxCategory category) {
    id = category.id!;
    name = category.name;
    selectedIcon = Icon(
      IconData(
        int.parse(category.icon, radix: 16),
        fontFamily: 'MaterialIcons',
      ),
    );
    selectedColor = Color(category.color);

    initialCategory = category;
  }

  TxCategory? initialCategory;
}
