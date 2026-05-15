import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../buttons/rounded_corner_button.dart';

class AmslLoadingScreen extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final Function? onBackButton;
  final String label;

  const AmslLoadingScreen({
    super.key,
    this.backgroundColor = Colors.white,
    this.label = "Loading...",
    this.color = Colors.black,
    this.onBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/avatar_images/amsl_thinking.svg",
              height: 200,
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(20),
            (onBackButton != null)
                ? RoundedCornerButton(
                    mainAxisSize: MainAxisSize.min,
                    label: "Zurück",
                    onTap: () => onBackButton!(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
