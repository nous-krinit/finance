import 'package:my_finance/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../models/category.dart';
import '../../../services/database_service.dart';

class CategoriesViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();

  List<TxCategory> get categories => _databaseService.getCachedCategories();

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

  Future<void> showDialog(TxCategory category) async {
    final result = await _dialogService.showCustomDialog(
        variant: DialogType.delete,
        title: 'Do you want to delete this category?');

    if (result != null && result.data == 'Yes') {
      await _databaseService.deleteCategory(category);
      await _databaseService.getCategories();
      categories;
      rebuildUi();
      notifyListeners();
    } else {
      rebuildUi();
    }
  }

  void createCategory() {
    _navigationService.navigateToCreateCategoryView();
  }

  void editCategory(TxCategory category) {
    _navigationService.navigateToEditCategoryView(category: category);
  }
}
