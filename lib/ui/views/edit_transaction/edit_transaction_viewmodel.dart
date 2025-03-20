import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/models/transaction.dart';
import 'package:my_finance/ui/views/create_transaction/create_transaction_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/category.dart';
import '../../../services/database_service.dart';

class EditTransactionViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _databaseService = locator<DatabaseService>();

  TxCategory? selectedCategory;
  late int id;
  late String type;
  late int amount;
  late String? note;

  List<TxCategory> get categories => _databaseService.getCachedCategories();

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

  Future saveTransaction(int? id) async {
    String finalDate;
    if (dateValue != null) {
      finalDate = '${dateValue!.day}/${dateValue!.month}/${dateValue!.year}';
    } else {
      finalDate =
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    }
    final tx = AppTransaction(
        id: id,
        amount: int.parse(amountValue!),
        type: type,
        category: selectedCategory?.name ?? 'Food',
        date: finalDate,
        note: noteValue);
    print('$tx');
    await _databaseService.updateTransaction(tx);
    await _databaseService.getTransactions();
    _navigationService.replaceWithHomeView();
  }

  void setInitialData(AppTransaction transaction) {
    id = transaction.id!;
    selectedCategory = (categories
            .where((category) => category.name == transaction.category)
            .toList())
        .first;
    type = transaction.type;
    amount = transaction.amount;
    note = transaction.note;
    initialTransaction = transaction;
  }

  AppTransaction? initialTransaction;
}
