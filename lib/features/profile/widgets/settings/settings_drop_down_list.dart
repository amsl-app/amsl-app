import 'package:flutter/material.dart';

class SettingsDropDownList extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final String label;
  final Function onChange;

  const SettingsDropDownList({
    super.key,
    required this.initialValue,
    required this.items,
    required this.onChange,
    required this.label,
  });

  @override
  State<SettingsDropDownList> createState() => _SettingsDropDownListState();
}

class _SettingsDropDownListState extends State<SettingsDropDownList> {
  String? newValue;

  void setValue(String value) {
    widget.onChange(value);
    setState(() {
      newValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    newValue ??= widget.initialValue;

    final theme = Theme.of(context);

    TextStyle style = theme.textTheme.bodyLarge!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: theme.textTheme.titleMedium!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton(
                      underline: Container(),
                      borderRadius: BorderRadius.circular(12),
                      value: newValue!,
                      items: widget.items
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: style),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setValue(value);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: newValue != "Keine Angabe",
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setValue("Keine Angabe"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
