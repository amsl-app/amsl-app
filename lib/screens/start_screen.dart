import 'package:amsl_app/authentication/async_login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

import '../features/tracking/tracking.dart';
import '../features/preferences/preferences.dart';
import '../hikari/exception.dart';
import '../widgets/dialogs/amsl_dialog.dart';

TextStyle headerStyle() {
  return const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300);
}

TextStyle bodyStyle() {
  return const TextStyle(fontSize: 16.0, color: Colors.black);
}

TextStyle bold() {
  return const TextStyle(fontWeight: FontWeight.bold);
}

TextStyle underline() {
  return const TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.black,
  );
}

class StartScreen extends StatefulHookConsumerWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  static final log = Logger("LoginScreen");
  String? error;
  Future<bool>? authentication;
  bool dpChecked = false;
  bool allow_tracking = false;
  bool allow_crash_reporting = false;
  PageController pageController = PageController();

  Future<bool> _auth(BuildContext context) async {
    final asyncLogin = ref.read(asyncLoginProvider.notifier);

    authentication = (context) async {
      await asyncLogin.login();

      if (!mounted) return false;
      log.info("Authentication successful");
      return true;
    }(context);
    try {
      return (await authentication!);
    } finally {
      authentication = null;
    }
  }

  Future<bool> authenticate(BuildContext context) async {
    if (authentication != null) {
      return authentication!;
    }
    log.info("Authenticating ...");
    return _auth(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Theme(
                        data: theme.copyWith(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: _buildStartScreen(context, pageController),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Scrollbar(child: _buildLogInScreen(context)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartScreen(
    BuildContext context,
    PageController pageController,
  ) {
    return Column(
      children: [
        const Gap(20),
        SvgPicture.asset(
          "assets/images/welcome_screen/login.svg",
          height: 200,
          fit: BoxFit.cover,
        ),
        const Gap(10),
        Text(
          "Datenschutz und Einwilligungserklärung",
          textAlign: TextAlign.center,
          style: headerStyle(),
        ),
        const Gap(20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    "Damit ein Login möglich ist, benötigen wir deine Bestätigung der Kenntnisnahme der ",
                children: [
                  TextSpan(
                    text: "Datenschutzerklärung",
                    style: underline(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launchUrl(
                          Uri.parse("https://amsl.app/app/datenschutz"),
                        );
                      },
                  ),
                  const TextSpan(text: " und der "),
                  TextSpan(
                    text: "Einwilligungserklärung.",
                    style: underline(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launchUrl(
                          Uri.parse("https://amsl.app/app/einwilligung"),
                        );
                      },
                  ),
                  const TextSpan(text: "\n Lies dir beides gut durch."),
                ],
                style: bodyStyle(),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(10),
        GestureDetector(
          onTap: () => setState(() {
            dpChecked = !dpChecked;
          }),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: const Color.fromRGBO(47, 132, 241, 1),
                value: dpChecked,
                onChanged: (value) => setState(() {
                  dpChecked = value!;
                }),
                visualDensity: VisualDensity.compact,
              ),
              const Expanded(
                child: Text(
                  "Ich habe die zugehörige Datenschutzerklärung und die Einwilligungserklärung zur Kenntnis genommen",
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        GestureDetector(
          onTap: () => setState(() {
            allow_tracking = !allow_tracking;
          }),
          child: Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: const Color.fromRGBO(47, 132, 241, 1),
                value: allow_tracking,
                onChanged: (value) => setState(() {
                  allow_tracking = value!;
                }),
                visualDensity: VisualDensity.compact,
              ),
              Expanded(
                child: Text("${TrackingConstants.analyticsLabel} (optional)"),
              ),
            ],
          ),
        ),
        const Gap(10),
        GestureDetector(
          onTap: () => setState(() {
            allow_crash_reporting = !allow_crash_reporting;
          }),
          child: Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: const Color.fromRGBO(47, 132, 241, 1),
                value: allow_crash_reporting,
                onChanged: (value) => setState(() {
                  allow_crash_reporting = value!;
                }),
                visualDensity: VisualDensity.compact,
              ),
              Expanded(
                child: Text(
                  "${TrackingConstants.crashReportingLabel} (optional)",
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        TextButton(
          onPressed: dpChecked
              ? () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              : null,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: dpChecked
                ? WidgetStateProperty.all<Color>(
                    const Color.fromRGBO(47, 132, 241, 1),
                  )
                : WidgetStateProperty.all<Color>(
                    const Color.fromRGBO(226, 226, 226, 1.0),
                  ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            elevation: WidgetStateProperty.all<double>(2.0),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Text(
              'Weiter',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  Widget _buildLogInScreen(BuildContext context) {
    return Column(
      children: <Widget>[
        const Gap(20),
        SvgPicture.asset(
          "assets/images/welcome_screen/login.svg",
          height: 200,
          fit: BoxFit.cover,
        ),
        Text("Anmelden", style: headerStyle()),
        const Gap(20),
        Text(
          "Bitte melde an, um loszulegen.\n\nViel Spaß!",
          textAlign: TextAlign.center,
          style: bodyStyle(),
        ),
        const Gap(30),
        TextButton(
          onPressed: () async {
            try {
              await authenticate(context);
              if (!context.mounted) {
                log.severe("Context not mounted on login");
                return;
              }

              final prefNotifier = ref.read(preferencesProvider.notifier);
              prefNotifier.setTrackingPermission(allow_tracking);
              prefNotifier.setCrashReportingPermission(allow_crash_reporting);

              //TODO: handle back button on android
              context.goNamed("home");
            } on AuthenticationException catch (e) {
              showAmslBottomSheet(
                error: true,
                context: context,
                content: e.message,
                buttonBar: [],
                onClose: () => Navigator.pop(context),
              );
            }
          },
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(
              const Color.fromRGBO(47, 132, 241, 1),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            elevation: WidgetStateProperty.all<double>(2.0),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        // const Gap(30),
        // Row(
        //   children: [
        //     Expanded(
        //         child: Visibility(
        //             visible: error != null,
        //             child: Container(
        //               decoration: BoxDecoration(
        //                   border: Border.all(
        //                       color: theme.colorScheme.onError, width: 3),
        //                   borderRadius: BorderRadius.circular(5)),
        //               padding: const EdgeInsets.symmetric(horizontal: 10),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Container(
        //                       padding: const EdgeInsets.only(left: 10),
        //                       child: Text(
        //                         error ?? "",
        //                         style: theme.textTheme.titleMedium!
        //                             .copyWith(color: theme.colorScheme.onError),
        //                       )),
        //                   IconButton(
        //                       onPressed: () {
        //                         setState(() {
        //                           error = null;
        //                         });
        //                       },
        //                       icon: const Icon(
        //                         Icons.close,
        //                         color: Colors.black,
        //                       ))
        //                 ],
        //               ),
        //             )))
        //   ],
        // ),
      ],
    );
  }
}
