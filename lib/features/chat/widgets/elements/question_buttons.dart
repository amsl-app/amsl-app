import 'package:amsl_app/features/chat/models/buttons.dart';
import 'package:amsl_app/features/chat/widgets/elements/question_button.dart';
import 'package:flutter/material.dart';

class QuestionButtons extends StatelessWidget {
  QuestionButtons(
    this.buttons, {
    required this.enabled,
    required this.pressedButtonIndex,
    required this.onButtonPressed,
    required this.isQuickReply,
    super.key,
  });

  final List<Button> buttons;
  final Function(Button button) onButtonPressed;
  final bool enabled;
  final bool isQuickReply;
  final int
  pressedButtonIndex; // index of button pressed, -1 if none is pressed
  final List<QuestionButton> questionButtons = [];

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    initButtonList();

    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 0, // isQuickReply ? 0 : 18,
        top: 2.0,
      ),
      child:
          lengthOfButtonTexts(questionButtons) <
              MediaQuery.of(context).size.width * 0.8
          ? centeredButtons(questionButtons)
          : scrollableButtons(
              questionButtons,
              context,
              scrollController: scrollController,
            ),
    );
  }

  void initButtonList() {
    questionButtons.clear();
    for (var i = 0; i < buttons.length; i++) {
      questionButtons.add(
        QuestionButton(
          buttons[i].text,
          enabled: enabled,
          pressed: i == pressedButtonIndex,
          notifyParent: () => onButtonPressed(buttons[i]),
          confirm: buttons[i].confirm,
        ),
      );
    }
  }

  int countButtonChars(List<String> titles) {
    var sum = 0;
    for (var title in titles) {
      sum += title.length;
    }
    return sum;
  }

  int lengthOfButtonTexts(List<QuestionButton> buttons) {
    int length = 0;
    for (var button in buttons) {
      length += (button.title.length * 8);
    }
    return length;
  }

  Widget scrollableButtons(
    List<QuestionButton> buttons,
    BuildContext context, {
    required ScrollController scrollController,
  }) {
    List<Widget> buttonList = [];
    for (var button in buttons) {
      buttonList.add(const SizedBox(width: 2));
      buttonList.add(button);
      buttonList.add(const SizedBox(width: 2));
    }
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeBottom: true),
      child: SafeArea(
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.bottom,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(children: buttonList),
            ),
          ),
        ),
      ),
    );
  }

  Widget centeredButtons(List<QuestionButton> buttons) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      textDirection: TextDirection.ltr,
      spacing: 8,
      children: buttons,
    );
  }
}
