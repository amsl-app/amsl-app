import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/tori/modules/module_assessment.dart';
import 'module_provider.dart';

final moduleAssessmentSetProvider = Provider.autoDispose
    .family<ModuleAssessmentSet?, String>(
      (ref, moduleID) =>
          ref.watch(moduleProvider.select((value) => value.value?[moduleID])),
      dependencies: [moduleProvider],
    );
