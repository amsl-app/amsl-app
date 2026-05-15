import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'check_upgrade.dart';

class UpgradeAlert extends StatefulHookConsumerWidget {
  final Widget child;

  const UpgradeAlert({super.key, required this.child});

  @override
  ConsumerState<UpgradeAlert> createState() => _UpgradeAlertState();
}

class _UpgradeAlertState extends ConsumerState<UpgradeAlert> {
  @override
  Widget build(BuildContext context) {
    UpgradeCheck().checkVersion(context: context, ref: ref);

    return widget.child;
  }
}
