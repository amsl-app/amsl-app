import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchWidget extends HookWidget {
  final void Function(String) onChange;

  const SearchWidget({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final searchIsActive = useState(false);
    final search = useState('');
    final focusNode = useFocusNode();
    final theme = Theme.of(context);

    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: !searchIsActive.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text(search.value, maxLines: 1)),
                  IconButton(
                    onPressed: () {
                      searchIsActive.value = true;
                      focusNode.requestFocus();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: searchIsActive.value,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextFormField(
                  focusNode: focusNode,
                  initialValue: search.value,
                  autofocus: true,
                  onEditingComplete: () {
                    searchIsActive.value = false;
                    focusNode.unfocus();
                  },
                  onFieldSubmitted: (value) {
                    searchIsActive.value = false;
                    focusNode.unfocus();
                  },
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  onChanged: (value) {
                    search.value = value;
                    onChange(value);
                  },
                  decoration: const InputDecoration(
                    hintText: "Suche ...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
