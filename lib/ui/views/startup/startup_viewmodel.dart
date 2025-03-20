import 'package:stacked/stacked.dart';
import 'package:my_finance/app/app.locator.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/database_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    await _databaseService.initialise();
    await _databaseService.getCategories();
    await _databaseService.getTransactions();
    _navigationService.replaceWithHomeView();
  }
}
