import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/app_text_styles.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'categories_sheet_model.dart';

class CategoriesSheet extends StackedView<CategoriesSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CategoriesSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CategoriesSheetModel viewModel,
    Widget? child,
  ) {
    List<TxCategory> categories = request.data ?? [];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Select Category',
            style: TextStyles.sheetLabel,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ElevatedButton(
                      onPressed: () {
                        viewModel.onCategorySelected(category);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Row(
                        children: [
                          Icon(
                            IconData(
                              int.parse(category.icon,
                                  radix: 16),
                              fontFamily: 'MaterialIcons',
                            ),
                            size: 40,
                            color: Color(category.color),
                          ),
                          horizontalSpaceMedium,
                          Text(
                            category.name,
                            style: TextStyles.categoryLabel,
                          )
                        ],
                      ),
                    );
                  })),
          verticalSpaceMedium,
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  CategoriesSheetModel viewModelBuilder(BuildContext context) =>
      CategoriesSheetModel();
}
