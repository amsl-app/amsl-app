class Variant {
  bool journalEnabled;
  bool keyCompetenceEnabled;
  bool onboardingEnabled;
  bool assessmentEnabled;

  Variant({
    required this.journalEnabled,
    required this.keyCompetenceEnabled,
    required this.onboardingEnabled,
    required this.assessmentEnabled,
  });

  factory Variant.all() {
    return Variant(
      journalEnabled: true,
      keyCompetenceEnabled: true,
      onboardingEnabled: true,
      assessmentEnabled: true,
    );
  }

  String get variantName {
    return "variant-${journalEnabled ? 'journal' : 'no-journal'}-${keyCompetenceEnabled ? 'key-competence' : 'no-key-competence'}-${onboardingEnabled ? 'onboarding' : 'no-onboarding'}-${assessmentEnabled ? 'assessment' : 'no-assessment'}";
  }
}
