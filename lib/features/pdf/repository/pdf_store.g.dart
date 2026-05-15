// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PDFStore)
final pDFStoreProvider = PDFStoreProvider._();

final class PDFStoreProvider
    extends $AsyncNotifierProvider<PDFStore, List<FilePointer>> {
  PDFStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pDFStoreProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          PDFStoreProvider.$allTransitiveDependencies0,
          PDFStoreProvider.$allTransitiveDependencies1,
          PDFStoreProvider.$allTransitiveDependencies2,
          PDFStoreProvider.$allTransitiveDependencies3,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$pDFStoreHash();

  @$internal
  @override
  PDFStore create() => PDFStore();
}

String _$pDFStoreHash() => r'07e760840cd229f8772c53f437630d8041c8b786';

abstract class _$PDFStore extends $AsyncNotifier<List<FilePointer>> {
  FutureOr<List<FilePointer>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FilePointer>>, List<FilePointer>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FilePointer>>, List<FilePointer>>,
              AsyncValue<List<FilePointer>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
