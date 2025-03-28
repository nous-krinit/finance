import 'package:flutter/material.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/transaction.dart';
import 'package:my_finance/ui/views/create_transaction/create_transaction_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../services/database_service.dart';
import '../../common/app_strings.dart';

class CreateTransactionViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _databaseService = locator<DatabaseService>();

  Set<int> selectedIndex = {0};
  String type = 'Expense';
  TxCategory? selectedCategory;
  List<TxCategory> get categories => _databaseService.getCachedCategories();

  Future selectionChanged(Set<int> newIndex) async {
    selectedIndex = newIndex;
    type = type == 'Expense' ? 'Income' : 'Expense';
    rebuildUi();
  }

  Future createTx() async {
    String finalDate;
    if (dateValue != null) {
      finalDate = '${dateValue!.day}/${dateValue!.month}/${dateValue!.year}';
    } else {
      finalDate =
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    }
    final tx = AppTransaction(
        amount: int.parse(amountValue!),
        type: type,
        category: selectedCategory?.name ?? 'Food',
        date: finalDate,
        note: noteValue);
    await _databaseService.addTransaction(tx);
    await _databaseService.getTransactions();
    _navigationService.replaceWithHomeView();
  }

  Future<void> showBottomSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.categories,
      title: 'Select Category',
      data: categories,
    );

    if (result != null) {
      selectedCategory = result.data;
      notifyListeners();
    }
  }
}
