import 'package:my_finance/models/category.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class CategoriesSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();

  void onCategorySelected(TxCategory category) {
    _bottomSheetService.completeSheet(SheetResponse(data: category));
  }
}
