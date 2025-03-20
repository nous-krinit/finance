import 'package:flutter/material.dart';
import 'package:my_finance/models/colorsAndIcons.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_text_styles.dart';
import 'icon_sheet_model.dart';

class IconSheet extends StackedView<IconSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const IconSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    IconSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Pick an Icon", style: TextStyles.sheetLabel),
        horizontalSpaceSmall,
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8, // 4x8 Grid
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: categoryIcons.length,
          itemBuilder: (context, index) {
            final icon = categoryIcons[index];
            return GestureDetector(
              onTap: () {
                viewModel.onIconSelected(icon);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: greyColor,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(icon, size: 24),
              ),
            );
          },
        ),
      ]),
    );
  }

  @override
  IconSheetModel viewModelBuilder(BuildContext context) => IconSheetModel();
}
