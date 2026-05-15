import 'package:amsl_app/features/profile/providers/user_provider.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/dialogs/amsl_dialog.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

void showAddModuleDialog(BuildContext context) {
  final theme = Theme.of(context);

  final controller = TextEditingController();
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: theme.colorScheme.onSurface, width: 2),
  );
  showAmslBottomSheet(
    bottomBar: true,
    context: context,
    onClose: () => Navigator.pop(context),
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            Text(
              "Um ein neues Modul hinzuzufügen, benötigst du einen Zugangscode.",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            TextField(
              controller: controller,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Gib einen Zugangscode ein",
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          ],
        );
      },
    ),
    buttonBar: [
      Consumer(
        builder: (context, ref, child) {
          return RoundedCornerButton(
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              try {
                if (await getUserApprovals(context, ref, controller.text)) {
                  await ref
                      .read(userPodProvider.notifier)
                      .postAccessToken(controller.text);

                  if (context.mounted) {
                    showMessage(context, label: "Erfolgreich hinzugefügt");
                    reloadAll(ref, context);
                    Navigator.of(context).pop();
                  }
                }
              } on Exception {
                if (context.mounted) {
                  showMessage(context, label: "Der Code ist ungültig");
                }
              }
            },
            label: "Hinzufügen",
          );
        },
      ),
    ],
  );
}

Future<bool> getUserApprovals(
  BuildContext context,
  WidgetRef ref,
  String token,
) async {
  final theme = Theme.of(context);

  bool hasConsent = false;

  final neededApprovals = await ref
      .read(userPodProvider.notifier)
      .getAccessApprovals(token);

  if (neededApprovals == null) {
    return true;
  }

  Widget body = RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "Um diesen Kurs zu hinzuzufügen, benötigen wir deine ",
          children: [
            TextSpan(
              text: "Einwilligung",
              style: theme.textTheme.bodyLarge!.copyWith(
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launchUrl(
                    Uri.parse(neededApprovals.declarationOfConsent),
                  );
                },
            ),
            TextSpan(
              text: " und deine Bestätigung der Kenntnisnahme der ",
              children: [
                TextSpan(
                  text: "Datenschutzerklärung.",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await launchUrl(Uri.parse(neededApprovals.privacyPolicy));
                    },
                ),
              ],
            ),
            const TextSpan(text: "\n Lies dir beides gut durch."),
            if (neededApprovals.participantInformation != null)
              TextSpan(
                text: "\n\nAußerdem kannst du hier die ",
                children: [
                  TextSpan(
                    text: "Teilnehmerinformation",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launchUrl(
                          Uri.parse(neededApprovals.participantInformation!),
                        );
                      },
                  ),
                  TextSpan(text: " zur Studie sehen."),
                ],
              ),
          ],
          style: theme.textTheme.bodyLarge,
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );
  if (context.mounted) {
    await showAmslBottomSheet(
      bottomBar: true,
      context: context,
      child: body,
      onClose: () => Navigator.pop(context),
      buttonBar: [
        RoundedCornerButton(
          label: "Zustimmen",
          onTap: () {
            Navigator.pop(context);
            hasConsent = true;
          },
        ),
      ],
    );
  }
  return hasConsent;
}
