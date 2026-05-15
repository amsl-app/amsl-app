import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  static final log = Logger("AboutUsState");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Über uns",
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/avatar_images/avatar.svg",
                    // width: 150,
                    height: 80,
                  ),
                  const Gap(20),
                  SvgPicture.asset(
                    "assets/images/profile/amsl_label.svg",
                    // width: 150,
                    height: 50,
                  ),
                ],
              ),
              const Gap(40),
              Text("Kontakt", style: theme.textTheme.titleMedium!),
              ListTile(
                leading: const Icon(Icons.mail_outline),
                title: Text(
                  "contact@amsl.app",
                  style: theme.textTheme.bodyLarge,
                ),
                onTap: () async {
                  var mail = await launchUrl(
                    Uri(scheme: "mailto", path: "contact@amsl.app"),
                  );
                  log.info("Launch mail url successful?: $mail");
                },
              ),
              ListTile(
                leading: const Icon(Ionicons.globe_outline),
                title: Text("amsl.app", style: theme.textTheme.bodyLarge),
                onTap: () async {
                  await launchUrl(Uri.parse("https://amsl.app"));
                },
              ),

              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(
                  "Kaiserstraße 89-93\nBuilding 05.20\nD-76133 Karlsruhe",
                  style: theme.textTheme.bodyLarge,
                ),
                onTap: () async {
                  final adresse = Uri.encodeComponent(
                    "Kaiserstraße 89-93 D-76133 Karlsruhe",
                  );
                  late Uri mapsUrl;

                  if (Platform.isIOS) {
                    mapsUrl = Uri.parse("https://maps.apple.com/?q=$adresse");
                  } else {
                    mapsUrl = Uri.parse(
                      "https://www.google.com/maps/search/?api=1&query=$adresse",
                    );
                  }

                  try {
                    if (await canLaunchUrl(mapsUrl)) {
                      await launchUrl(
                        mapsUrl,
                        mode: LaunchMode.externalNonBrowserApplication,
                      );
                    } else {
                      throw 'Maps URL could not be launched';
                    }
                  } on Exception catch (e) {
                    log.warning("Could not open the map: $e");
                    if (context.mounted) {
                      showMessage(context, error: true);
                    }
                  }
                },
              ),

              // const Divider(
              //   height: 40,
              // ),
              // SettingsButton(
              //     label: "Impressum",
              //     icon: const Icon(Icons.policy_outlined),
              //     onPressed: () {
              //       Beamer.of(context)
              //           .beamToNamed("/profile/about_us/legal_notice");
              //     },
              //     color: Colors.white),
              // const Gap(16),
              // SettingsButton(
              //   label: "App-Informationen",
              //   icon: const Icon(Icons.info_outline_rounded),
              //   onPressed: () {
              //     Beamer.of(context)
              //         .beamToNamed("/profile/about_us/app_information");
              //   },
              //   color: Colors.white,
              // ),
              // const Gap(100)
            ],
          ),
        ),
      ),
    );
  }
}
