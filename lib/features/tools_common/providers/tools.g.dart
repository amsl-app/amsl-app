// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tools.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tools)
final toolsProvider = ToolsProvider._();

final class ToolsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Tool>>,
          Map<String, Tool>,
          FutureOr<Map<String, Tool>>
        >
    with
        $FutureModifier<Map<String, Tool>>,
        $FutureProvider<Map<String, Tool>> {
  ToolsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toolsProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[variantPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          ToolsProvider.$allTransitiveDependencies0,
          ToolsProvider.$allTransitiveDependencies1,
          ToolsProvider.$allTransitiveDependencies2,
          ToolsProvider.$allTransitiveDependencies3,
          ToolsProvider.$allTransitiveDependencies4,
          ToolsProvider.$allTransitiveDependencies5,
        },
      );

  static final $allTransitiveDependencies0 = variantPodProvider;
  static final $allTransitiveDependencies1 =
      VariantPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      VariantPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      VariantPodProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      VariantPodProvider.$allTransitiveDependencies3;
  static final $allTransitiveDependencies5 =
      VariantPodProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$toolsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Tool>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Tool>> create(Ref ref) {
    return tools(ref);
  }
}

String _$toolsHash() => r'4eb780eb9776a49938073583e36d2e700604cfeb';
