import 'package:my_finance/app/app.bottomsheets.dart';
import 'package:my_finance/app/app.dialogs.dart';
import 'package:my_finance/app/app.locator.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/models/transaction.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/category.dart';
import '../../../services/database_service.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();

  String get counterLabel => 'Counter is: $_counter';
  String todayDate =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  List<AppTransaction> get transactions =>
      _databaseService.getCachedTransactions();
  List<TxCategory> get categories => _databaseService.getCachedCategories();
  List<AppTransaction> _filteredTransactions = [];
  List<AppTransaction> get filteredTransactions => _filteredTransactions;

  HomeViewModel() {
    _filteredTransactions = transactions
        .where((transaction) => transaction.date == todayDate)
        .toList();
  }

  int _counter = 0;
  Set<int> selectedIndex = {0};

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  Future<void> showDialog(AppTransaction transaction) async {
    final result = await _dialogService.showCustomDialog(
        variant: DialogType.delete,
        title: 'Do you want to delete this transaction?');

    if (result != null && result.data == 'Yes') {
      await _databaseService.deleteTransaction(transaction);
      await _databaseService.getTransactions();
      selectionChanged(selectedIndex);
      rebuildUi();
      notifyListeners();
    } else {
      rebuildUi();
    }
  }

  Future navigateToCreate() async {
    await _databaseService.getCategories();
    _navigationService.navigateToCreateTransactionView();
  }

  Future selectionChanged(Set<int> newIndex) async {
    selectedIndex = newIndex;
    int selectedValue = newIndex.first;

    List<String> dateParts = todayDate.split('/');
    DateTime today = DateTime(
        int.parse(dateParts[2]), // year
        int.parse(dateParts[1]), // month
        int.parse(dateParts[0]) // day
        );

    if (selectedValue == 0) {
      _filteredTransactions = transactions
          .where((transaction) => transaction.date == todayDate)
          .toList();
    } else if (selectedValue == 1) {
      DateTime weekAgo = today.subtract(Duration(days: 7));

      _filteredTransactions = transactions.where((transaction) {
        List<String> txDateParts = transaction.date.split('/');
        if (txDateParts.length != 3) return false;

        DateTime txDate = DateTime(
            int.parse(txDateParts[2]), // year
            int.parse(txDateParts[1]), // month
            int.parse(txDateParts[0]) // day
            );

        return txDate.isAfter(weekAgo) || txDate.isAtSameMomentAs(weekAgo);
      }).toList();
    } else if (selectedValue == 2) {
      _filteredTransactions = transactions.where((transaction) {
        List<String> txDateParts = transaction.date.split('/');
        if (txDateParts.length != 3) return false;

        DateTime txDate = DateTime(
            int.parse(txDateParts[2]), // year
            int.parse(txDateParts[1]), // month
            int.parse(txDateParts[0]) // day
            );

        return txDate.year == today.year && txDate.month == today.month;
      }).toList();
    } else {
      _filteredTransactions = transactions;
    }

    rebuildUi();
  }

  String getCategoryIcon(String categoryName) {
    TxCategory? category = categories.firstWhere(
      (cat) => cat.name == categoryName,
      orElse: () => TxCategory(
          id: 0, name: "Unknown", icon: "F036B", color: greyColor.toARGB32()),
    );
    return category.icon;
  }

  int getCategoryColor(String categoryName) {
    TxCategory? category = categories.firstWhere(
      (cat) => cat.name == categoryName,
      orElse: () => TxCategory(
          id: 0, name: "Unknown", icon: "F036B", color: greyColor.toARGB32()),
    );
    return category.color;
  }

  void navigateToEdit(AppTransaction transaction) {
    _navigationService.navigateToEditTransactionView(transaction: transaction);
  }

  Future navigatorBar(int index) async {
    if (index == 0) {
      await _databaseService.getTransactions();
      await _databaseService.getCategories();
      _navigationService.replaceWithHomeView();
    } else if (index == 1) {
      await _databaseService.getTransactions();
      await _databaseService.getCategories();
      _navigationService.replaceWithStatsView();
    } else {
      await _databaseService.getCategories();
      _navigationService.replaceWithCategoriesView();
    }
  }
}
