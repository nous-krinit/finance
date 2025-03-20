import 'package:flutter/material.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/colorsAndIcons.dart';
import '../../common/app_text_styles.dart';
import 'color_sheet_model.dart';

class ColorSheet extends StackedView<ColorSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ColorSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ColorSheetModel viewModel,
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
        Text("Pick a Color", style: TextStyles.sheetLabel),
        horizontalSpaceSmall,
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8, // 4x8 Grid
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: categoryColors.length,
          itemBuilder: (context, index) {
            final color = categoryColors[index];
            return GestureDetector(
              onTap: () {
                viewModel.onColorSelected(color);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                width: 40,
                height: 40,
              ),
            );
          },
        ),
      ]),
    );
  }

  @override
  ColorSheetModel viewModelBuilder(BuildContext context) => ColorSheetModel();
}
