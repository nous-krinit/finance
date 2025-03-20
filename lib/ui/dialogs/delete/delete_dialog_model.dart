import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class DeleteDialogModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  void onOptionSelected(String option) {
    _dialogService.completeDialog(DialogResponse(data: option));
  }
}
