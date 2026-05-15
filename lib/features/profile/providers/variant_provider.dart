import 'package:amsl_app/features/profile/providers/user_provider.dart';
import 'package:amsl_app/models/hikari/user/user.dart';
import 'package:amsl_app/variants.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'variant_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [UserPod])
class VariantPod extends _$VariantPod {
  static final log = Logger("VariantProvider");

  @override
  Future<Variant> build() async {
    //When we update just reset the state to the old state.
    if (state.hasError) {
      state = AsyncError(state.error!, state.stackTrace!);
    } else if (state.hasValue) {
      state = AsyncData(state.requireValue);
    }
    final variant = await ref.watch(
      userPodProvider.selectAsync((value) => value.variant),
    );
    final effectiveVariant = getEffectiveVariant(variant);
    log.info("Variant: $effectiveVariant (User: $variant)");
    return effectiveVariant;
  }

  Variant getEffectiveVariant(Variant? userVariant) {
    Variant? effectiveVariant;
    effectiveVariant ??= userVariant;
    if (effectiveVariant != null) {
      return effectiveVariant;
    }
    return state.asData?.value ?? Variant.all();
  }

  Future<Variant> _updateState() async {
    User user;
    final asyncUser = ref.read(userPodProvider);
    if (asyncUser.hasValue) {
      user = asyncUser.requireValue;
      log.info("Getting User: ${user.name} with variant ${user.variant}");
    } else {
      user = await ref.read(userPodProvider.notifier).reloadUser();
    }
    final vairant = getEffectiveVariant(user.variant);
    log.info("Updating variant to $vairant");
    return vairant;
  }

  Future<Variant> reload() async {
    if (!state.hasValue) {
      state = await AsyncValue.guard(_updateState);
    }
    return await update((oldState) => _updateState());
  }
}
