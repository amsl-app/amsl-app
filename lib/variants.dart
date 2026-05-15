class Variant {
  bool journalEnabled;
  bool keyCompetenceEnabled;
  bool onboardingEnabled;

  Variant({
    required this.journalEnabled,
    required this.keyCompetenceEnabled,
    required this.onboardingEnabled,
  });

  factory Variant.all() {
    return Variant(
      journalEnabled: true,
      keyCompetenceEnabled: true,
      onboardingEnabled: true,
    );
  }

  String get variantName {
    return "variant-${journalEnabled ? 'journal' : 'no-journal'}-${keyCompetenceEnabled ? 'key-competence' : 'no-key-competence'}-${onboardingEnabled ? 'onboarding' : 'no-onboarding'}";
  }
}
