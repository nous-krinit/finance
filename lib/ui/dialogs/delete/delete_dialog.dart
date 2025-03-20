import 'package:flutter/material.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/app_text_styles.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'delete_dialog_model.dart';

const double _graphicSize = 60;

class DeleteDialog extends StackedView<DeleteDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DeleteDialogModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: primaryColor,
      title: Text(request.title ?? 'Delete?'),
      titleTextStyle: TextStyles.dialogTitle,
      actions: <Widget>[
        TextButton(
          child: Text(
            'No',
            style: TextStyles.dialogConfirm,
          ),
          onPressed: () {
            viewModel.onOptionSelected('No');
          },
        ),
        TextButton(
          child: Text(
            'Yes',
            style: TextStyles.dialogConfirm,
          ),
          onPressed: () {
            viewModel.onOptionSelected('Yes');
          },
        ),
      ],
    );
  }

  @override
  DeleteDialogModel viewModelBuilder(BuildContext context) =>
      DeleteDialogModel();
}
