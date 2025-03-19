import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/ui/widgets/common/input_field/input_field_model.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class InputField extends StackedView<InputFieldModel> {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback? onTap;
  final bool? readOnly;

  const InputField(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.label,
      this.readOnly,
      this.onTap,
      this.keyboardType,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InputFieldModel viewModel,
    Widget? child,
  ) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      readOnly: readOnly ?? false,
      onTap: onTap,
      controller: controller,
      style: TextStyles.input,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        icon: Icon(
          icon,
          color: secondaryColor,
        ),
        labelStyle: TextStyles.label,
        labelText: label,
      ),
    );
  }

  @override
  InputFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      InputFieldModel();
}
