import 'package:amsl_app/features/journal/providers/focus/focus.dart';
import 'package:amsl_app/features/journal/widgets/focus/add_focus_dialog.dart';
import 'package:amsl_app/features/journal/widgets/focus/focus_icon.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconoir_flutter/regular/plus.dart';

import '../../../../models/tori/journal/journal_focus.dart';

class FocusSelectionList extends StatefulHookConsumerWidget {
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final Color labelColor;
  final Color iconColor;
  final Color activeIconColor;
  final bool bottomPadding;
  final Function(List<String>) onSelectionChanged;

  final int columns;
  final double gap;

  const FocusSelectionList({
    super.key,
    this.columns = 3,
    this.gap = 20,
    this.bottomPadding = true,
    required this.labelColor,
    required this.iconColor,
    required this.activeIconColor,
    required this.backgroundColor,
    required this.activeBackgroundColor,
    required this.onSelectionChanged,
  });

  @override
  ConsumerState<FocusSelectionList> createState() => _FocusSelectionListState();
}

class _FocusSelectionListState extends ConsumerState<FocusSelectionList> {
  late int rows;

  final ScrollController _scrollController = ScrollController();
  List<String> selectedFoci = [];

  void onSelect(String focusID) {
    List<String> newList = List.of(selectedFoci);
    if (selectedFoci.contains(focusID)) {
      trackEvent(
        category: TrackingCategory.journalFocus,
        action: TrackingAction.deselect,
        name: focusID,
      );
      newList.remove(focusID);
    } else {
      trackEvent(
        category: TrackingCategory.journalFocus,
        action: TrackingAction.select,
        name: focusID,
      );
      newList.add(focusID);
    }
    setState(() {
      selectedFoci = newList;
    });
    widget.onSelectionChanged(newList);
  }

  Widget getCurrentIcon(List foci, int columnIndex, int rowIndex, double size) {
    int index = rowIndex * widget.columns + columnIndex;

    if (index > foci.length) return Container();

    if (index == foci.length) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AddFocusRow(),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    color: widget.backgroundColor.withValues(alpha: 0.5),
                    child: Plus(color: widget.iconColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      child: FocusIcon(
        size: size,
        iconColor: widget.iconColor,
        activeIconColor: widget.activeIconColor,
        backgroundColor: widget.backgroundColor,
        activeBackgroundColor: widget.activeBackgroundColor,
        labelColor: widget.labelColor,
        focus: foci[index],
        selected: selectedFoci.contains(foci[index].id),
      ),
      onTap: () => onSelect(foci[index].id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(focusProvider)
        .build(
          context,
          builder: (context, focuList) {
            List<JournalFocus> foci = focuList!.values
                .where((element) => !element.hidden)
                .toList();
            rows = ((foci.length + 1) / widget.columns)
                .ceil(); //plus 1 for add Icon

            return LayoutBuilder(
              builder: (context, constraints) {
                double sumSize =
                    (constraints.maxWidth - (widget.columns - 1) * widget.gap);
                double size = sumSize / widget.columns;

                return Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        rows + 1,
                        (rowIndex) => rowIndex == rows
                            ? Gap(widget.bottomPadding ? 100 : 0)
                            : Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    widget.columns,
                                    (columnIndex) => SizedBox(
                                      width: size,
                                      height: size,
                                      child: getCurrentIcon(
                                        foci,
                                        columnIndex,
                                        rowIndex,
                                        size,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
  }
}
