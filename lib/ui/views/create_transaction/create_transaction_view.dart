import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/ui/views/create_transaction/create_transaction_view.form.dart';
import 'package:my_finance/ui/widgets/common/input_field/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import 'create_transaction_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'amount'),
  FormTextField(name: 'note'),
  FormDateField(name: 'date')
])
class CreateTransactionView extends StackedView<CreateTransactionViewModel>
    with $CreateTransactionView {
  const CreateTransactionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateTransactionViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('New Transaction', style: TextStyles.appBar),
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
            onPressed: () {},
            child: Text('Create', style: TextStyles.appBarButton),
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
                  verticalSpaceSmall,
                  SizedBox(
                      width: double.infinity,
                      child: SegmentedButton(
                          segments: [
                            ButtonSegment(
                                value: 0,
                                label: Text('Expense',
                                    style: TextStyles.appBarButton
                                        .copyWith(fontSize: 14)),
                                icon: Icon(
                                  Icons.payments,
                                  color: primaryColor,
                                )),
                            ButtonSegment(
                                value: 1,
                                label: Text(
                                  'Income',
                                  style: TextStyles.appBarButton
                                      .copyWith(fontSize: 14),
                                ),
                                icon: Icon(Icons.account_balance_wallet,
                                    color: primaryColor)),
                          ],
                          selected: viewModel.selectedIndex,
                          onSelectionChanged: (Set<int> newSelection) {
                            viewModel.selectionChanged(newSelection);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  return states.contains(WidgetState.selected)
                                      ? greyColor
                                      : secondaryColor;
                                },
                              ),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))))),
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
                        firstDate: DateTime.now(),
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
  void onViewModelReady(CreateTransactionViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  CreateTransactionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateTransactionViewModel();

  @override
  void onDispose(CreateTransactionViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
