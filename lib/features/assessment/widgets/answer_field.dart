import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnswerField extends StatelessWidget {
  final String? value;
  final Function onChange;
  final String label;
  final String hintText;
  final bool multiLine;
  final Color labelColor;

  const AnswerField({
    super.key,
    required this.label,
    required this.onChange,
    required this.value,
    required this.labelColor,
    required this.hintText,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    String value = (this.value ?? "");

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(color: labelColor),
        ),
        const Gap(25),
        Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              onChange(value);
            }
          },
          child: TextFormField(
            keyboardType: TextInputType.text,
            initialValue: value,
            minLines: multiLine ? 2 : 1,
            maxLines: multiLine ? 5 : 1,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            onEditingComplete: () => onChange(value),
            onChanged: (newValue) => value = newValue,
            decoration: InputDecoration(
              hintStyle: theme.textTheme.titleSmall!.copyWith(
                color: Colors.grey,
              ),
              label: Text(hintText),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: theme.colorScheme.onSurface,
                  width: 2,
                ),
              ),
              labelStyle: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
