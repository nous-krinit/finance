import 'package:flutter/material.dart';
import 'package:my_finance/ui/widgets/common/navigator_bar/navigator_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';

import '../../common/app_text_styles.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: NavigatorBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          viewModel.navigatorBar(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.navigateToCreate();
        },
        foregroundColor: primaryColor,
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
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
                                label: Text('Day',
                                    style: TextStyles.appBarButton
                                        .copyWith(fontSize: 12)),
                                icon: const Icon(
                                  Icons.calendar_view_day_rounded,
                                  color: primaryColor,
                                )),
                            ButtonSegment(
                                value: 1,
                                label: Text(
                                  'Week',
                                  style: TextStyles.appBarButton
                                      .copyWith(fontSize: 12),
                                ),
                                icon: const Icon(Icons.calendar_view_week,
                                    color: primaryColor)),
                            ButtonSegment(
                                value: 2,
                                label: Text(
                                  'Month',
                                  style: TextStyles.appBarButton
                                      .copyWith(fontSize: 12),
                                ),
                                icon: const Icon(Icons.calendar_month_rounded,
                                    color: primaryColor)),
                            ButtonSegment(
                                value: 3,
                                label: Text(
                                  'All',
                                  style: TextStyles.appBarButton
                                      .copyWith(fontSize: 12),
                                ),
                                icon: const Icon(Icons.calendar_today_rounded,
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
                  Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.filteredTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction =
                                viewModel.filteredTransactions[index];
                            return Card(
                              color: secondaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0,
                                    right: 4.0,
                                    top: 8.0,
                                    bottom: 8.0),
                                child: Row(
                                  children: [
                                    horizontalSpaceSmall,
                                    Icon(
                                      IconData(
                                        int.parse(
                                            viewModel.getCategoryIcon(
                                                transaction.category),
                                            radix: 16),
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      size: 32,
                                      color: Color(viewModel.getCategoryColor(
                                          transaction.category)),
                                    ),
                                    Expanded(
                                        child: ListTile(
                                      title: Text(
                                        transaction.category,
                                        style: TextStyles.cardTitle,
                                      ),
                                      subtitle: Text(
                                        'Date: ${transaction.date} Note: ${transaction.note}',
                                        style: TextStyles.cardDescription,
                                        maxLines: 2,
                                      ),
                                    )),
                                    horizontalSpaceSmall,
                                    Text(
                                      transaction.type == 'Expense'
                                          ? '-${transaction.amount}'
                                          : '+${transaction.amount}',
                                      style: TextStyles.cardTitle.copyWith(
                                          color: transaction.type == 'Expense'
                                              ? lossColor
                                              : profitColor),
                                    ),
                                    horizontalSpaceSmall,
                                    IconButton(
                                        onPressed: () {
                                          viewModel.navigateToEdit(transaction);
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          viewModel.showDialog(transaction);
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
