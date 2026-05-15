import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PackageLicenseData {
  final String packageName;
  final List<LicenseEntry> licenseEntry;

  PackageLicenseData({required this.packageName, required this.licenseEntry});
}

class PackageLicense extends StatelessWidget {
  final PackageLicenseData licenseData;

  const PackageLicense({super.key, required this.licenseData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        scrolledUnderElevation: 0.0,
        title: Text(licenseData.packageName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Text(
              licenseData.licenseEntry
                  .map(
                    (e) => e.paragraphs
                        .map((e) => e.text)
                        .toList()
                        .reduce((value, element) => "$value\n$element"),
                  )
                  .reduce((value, element) => "$value\n\n$element"),
            ),
          ),
        ),
      ),
    );
  }
}
