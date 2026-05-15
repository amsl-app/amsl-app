import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final String? initialValue;
  final Function(String?) onEditingComplete;
  final String label;
  final TextInputType keyboardType;

  const SettingsTextField({
    super.key,
    required this.initialValue,
    required this.onEditingComplete,
    required this.label,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<SettingsTextField> createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  late TextEditingController _controller;

  void setValue(String value, {bool updateController = false}) {
    setState(() {
      if (updateController) _controller.text = value;
    });
    if (value.isNotEmpty) {
      widget.onEditingComplete(value);
    } else {
      widget.onEditingComplete(null);
    }
  }

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  child: TextFormField(
                    controller: _controller,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    keyboardType: widget.keyboardType,
                    decoration: InputDecoration(
                      hintText: "Keine Angabe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onEditingComplete: () => setValue(_controller.text),
                  ),
                ),
                Visibility(
                  visible: _controller.value.text.isNotEmpty,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setValue("", updateController: true),
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
