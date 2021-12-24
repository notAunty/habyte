import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.alwaysValidate = false,
    this.isInt = false,
    this.isDone = false,
    this.isNumber = false,
    this.isPositive = false,
    this.divisibleBy = -1,
    this.readOnly = false,
    this.isRequired = false,
    this.isMultiline = false,
    this.maxWords = 300,
    this.hintText = '',
    this.onChanged,
    this.onTap,
    this.maxInt=999999999999999999,
    this.minInt=0,
    this.onEditingComplete,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final bool alwaysValidate;
  final bool isNumber;
  final bool isInt;
  final bool isPositive;
  final int divisibleBy;
  final bool isDone;
  final bool readOnly;
  final bool isRequired;
  final bool isMultiline;

  final int maxWords;
  final int maxInt;
  final int minInt;
  final String hintText;
  final TextEditingController controller;

  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isNumeric = (isInt || isNumber || isPositive || divisibleBy > -1);
    // if (isInt || isPositive || divisibleBy > -1) isNumber = true;

    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      maxLines: isMultiline ? null : 1,
      autovalidateMode: alwaysValidate
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,

      // validator: (v) => (maxWords > 0 && v.split(' ').length > maxWords)
      //   ? 'Text length is greater than $maxWords words.'
      //   : null,

      validator: (String? str) {
        try {
          if (isRequired && (str == null || str.isEmpty)) {
            return '* This field is required.';
          } else if (isInt &&
              ((int.tryParse(str!) == null) || str.contains('.'))) {
            return 'Must be an integer.';
          }else if (isInt &&
              ((int.tryParse(str!)! > maxInt))) {
            return 'Maximum value is $maxInt.';
          }else if (isInt &&
              ((int.tryParse(str!)! < minInt))) {
            return 'Minimum value is $minInt.';
          } else if (isNumeric && double.tryParse(str!) == null) {
            return 'Must be a number.';
          } else if (isPositive && double.parse(str!) < 0) {
            return 'Must be a positive number.';
          } else if (divisibleBy != -1 &&
              (double.parse(str!) % divisibleBy != 0)) {
            return 'Must be divisible by $divisibleBy.';
          } else if (maxWords > 0 &&
              str!.split(RegExp(r'\s')).length > maxWords) {
            return 'Text length is greater than $maxWords words.';
          } else {
            return null;
          }
        } catch (err) {
          return null;
        }
      },

      keyboardType: isInt
          ? TextInputType.number
          : (isNumeric
              ? const TextInputType.numberWithOptions(decimal: true)
              : (isMultiline ? TextInputType.multiline : TextInputType.text)),
      textInputAction: isDone
          ? TextInputAction.done
          : (isMultiline ? TextInputAction.newline : TextInputAction.next),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        focusColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        // contentPadding: EdgeInsets.all(8),
      ),
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) =>
          (!isNumeric && maxWords > 0)
              ? Text(
                  '${controller.text.split(RegExp(r'\s')).length}/$maxWords word')
              : Container(),
    );
  }
}

class CustomTextFieldLabel extends StatelessWidget {
  const CustomTextFieldLabel(
      {Key? key, required this.label, required this.child})
      : super(key: key);

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
            opacity: 0.8,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1,
            )),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
