import 'package:flutter/material.dart';

class Feedback {
  final bool? feedback;
  final String? explanation;

  Feedback({this.feedback, this.explanation});

  Feedback copyWith({bool? feedback, String? explanation}) {
    return Feedback(
      feedback: feedback ?? this.feedback,
      explanation: explanation ?? this.explanation,
    );
  }
}

class QuizFeedback extends StatefulWidget {
  const QuizFeedback({super.key, required this.onChange});

  final Function(Feedback) onChange;

  @override
  State<QuizFeedback> createState() => QuizFeedbackState();
}

class QuizFeedbackState extends State<QuizFeedback> {
  bool? feedback;
  String? explanation;

  FocusNode focusNode = FocusNode();

  void onChange() {
    widget.onChange(Feedback(feedback: feedback, explanation: explanation));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Wie hat dir die Frage gefallen?",
                maxLines: 2,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            IconButton(
              icon: Icon(
                feedback == true ? Icons.thumb_up : Icons.thumb_up_outlined,
              ),
              onPressed: () {
                setState(() => feedback = true);
                onChange();
              },
            ),
            IconButton(
              icon: Icon(
                feedback == false
                    ? Icons.thumb_down
                    : Icons.thumb_down_outlined,
              ),
              onPressed: () {
                setState(() => feedback = false);
                onChange();
              },
            ),
          ],
        ),
        if (feedback != null)
          TextField(
            focusNode: focusNode,
            onChanged: (s) {
              explanation = s;
              onChange();
            },
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: feedback!
                  ? "Was hat dir gefallen?"
                  : "Was hat dir nicht gefallen?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
      ],
    );
  }
}
