import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class CreateTransactionViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();

  Set<int> selectedIndex = {0};

  Future selectionChanged(Set<int> newIndex) async {
    selectedIndex = newIndex;
    rebuildUi();
  }
}
