import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/ui/views/edit_category/edit_category_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/input_field/input_field.dart';
import 'edit_category_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'category'),
])
class EditCategoryView extends StackedView<EditCategoryViewModel> with $EditCategoryView{
  final TxCategory category;
  EditCategoryView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditCategoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text('Edit Category', style: TextStyles.appBar),
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
              if (viewModel.categoryValue == null ||
                  viewModel.categoryValue == '') {
                final snackBar = SnackBar(
                  content: Text(
                    'Enter category name',
                    style: TextStyles.appBarButton,
                  ),
                  backgroundColor: secondaryColor,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                viewModel.editCategory(category.id);
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
                    controller: categoryController,
                    icon: Icons.category,
                    label: 'Category',
                  ),
                  verticalSpaceMedium,
                  Row(
                    children: [
                      Text(
                        'Category Color',
                        style: TextStyles.categoryLabel,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.showBottomSheet();
                        },
                        child: child,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.selectedColor,
                          shape: CircleBorder(),
                        ),
                      )
                    ],
                  ),
                  verticalSpaceMedium,
                  Row(
                    children: [
                      Text(
                        'Category Icon',
                        style: TextStyles.categoryLabel,
                      ),
                      horizontalSpaceSmall,
                      IconButton(
                        onPressed: () {
                          viewModel.showIconSheet();
                        },
                        icon: Icon(
                          viewModel.selectedIcon.icon,
                          size: 40,
                          color: greyColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(EditCategoryViewModel viewModel) {
    viewModel.setInitialData(category);
    syncFormWithViewModel(viewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.initialCategory != null) {
        categoryController.text = viewModel.initialCategory!.name;
      }
    });
  }

  @override
  EditCategoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EditCategoryViewModel();
}
