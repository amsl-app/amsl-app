import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/buttons/rounded_corner_button.dart';
import '../../widgets/dialogs/amsl_dialog.dart';

Future<bool> checkApproval(
  BuildContext context,
  SharedPreferences sharedPreferences, {
  required String key,
  bool bottomBar = false,
}) async {
  bool accepted = sharedPreferences.getBool(key) ?? false;
  return accepted ||
      await showWarning(
        context,
        sharedPreferences,
        key: key,
        bottomBar: bottomBar,
      );
}

Future<bool> showWarning(
  BuildContext context,
  SharedPreferences sharedPreferences, {
  required String key,
  bool bottomBar = false,
}) async {
  bool accepted = false;
  final theme = Theme.of(context);
  await showAmslBottomSheet(
    bottomBar: bottomBar,
    context: context,
    content:
        "Diese Funktion wird von einer KI betrieben, die ungenaue oder unangemessene Antworten generieren kann. Teile keine sensiblen oder persönlichen Informationen in diesem Chat, da die KI nicht in der Lage ist, deine Privatsphäre zu schützen. Durch die Nutzung dieser Funktion stimmst du zu, dass du die Antworten der KI kritisch hinterfragst und nicht als professionelle Beratung betrachten. Es wird keinerlei Gewähr für die Richtigkeit und Vollständigkeit der Inhalte übernommen.\n\nBist du damit einverstanden?",
    buttonBar: [
      RoundedCornerButton(
        label: "Abbrechen",
        onTap: () {
          Navigator.pop(context);
        },
        buttonColor: theme.colorScheme.surfaceContainer,
        borderColor: theme.colorScheme.primary,
        labelColor: theme.colorScheme.primary,
      ),
      RoundedCornerButton(
        label: "Einverstanden",
        onTap: () {
          sharedPreferences.setBool(key, true);
          accepted = true;
          Navigator.pop(context);
        },
      ),
    ],
  );
  return accepted;
}
