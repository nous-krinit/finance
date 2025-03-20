import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/models/transaction.dart';
import 'package:my_finance/ui/views/edit_transaction/edit_transaction_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/input_field/input_field.dart';
import 'edit_transaction_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'amount'),
  FormTextField(name: 'note'),
  FormTextField(name: 'category'),
  FormDateField(name: 'date')
])
class EditTransactionView extends StackedView<EditTransactionViewModel>
    with $EditTransactionView {
  final AppTransaction transaction;
  EditTransactionView({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditTransactionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Edit Transaction', style: TextStyles.appBar),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: secondaryColor),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            onPressed: () {
              if (viewModel.amountValue == null ||
                  viewModel.amountValue == '') {
                final snackBar = SnackBar(
                  content: Text(
                    'Enter the amount',
                    style: TextStyles.appBarButton,
                  ),
                  backgroundColor: secondaryColor,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                viewModel.saveTransaction(transaction.id);
              }
            },
            child: Text('Save', style: TextStyles.appBarButton),
          ),
          horizontalSpaceSmall
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpaceMedium,
                  InputField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    readOnly: true,
                    controller: TextEditingController(
                      text: viewModel.dateValue != null
                          ? "${viewModel.dateValue!.day}/${viewModel.dateValue!.month}/${viewModel.dateValue!.year}"
                          : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    ),
                    icon: Icons.calendar_month_rounded,
                    label: 'Date',
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        DateTime finalDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                        );
                        viewModel.setData(
                          viewModel.formValueMap
                            ..addAll({DateValueKey: finalDateTime}),
                        );
                      }
                    },
                  ),
                  verticalSpaceMedium,
                  InputField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: amountController,
                      icon: Icons.currency_rupee,
                      label: 'Amount'),
                  verticalSpaceMedium,
                  InputField(
                      controller: TextEditingController(
                        text: viewModel.selectedCategory?.name ??
                            viewModel.categories.first.name,
                      ),
                      readOnly: true,
                      onTap: () {
                        viewModel.showBottomSheet();
                      },
                      icon: Icons.sticky_note_2_sharp,
                      label: 'Category'),
                  verticalSpaceMedium,
                  InputField(
                      controller: noteController,
                      icon: Icons.sticky_note_2_sharp,
                      label: 'Notes'),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(EditTransactionViewModel viewModel) {
    if (transaction != null) {
      viewModel.setInitialData(transaction);
    }
    syncFormWithViewModel(viewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.initialTransaction != null) {
        amountController.text = viewModel.initialTransaction!.amount.toString();
        noteController.text = viewModel.initialTransaction!.note!;
      }
    });
  }

  @override
  EditTransactionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditTransactionViewModel();
}
