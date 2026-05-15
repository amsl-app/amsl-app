import 'dart:io';

import 'package:amsl_app/features/pdf/models/file_pointer.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'pdf_store.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class PDFStore extends _$PDFStore {
  static final log = Logger("PDFStore");
  late Directory _appDocDir;

  @override
  Future<List<FilePointer>> build() async {
    _appDocDir = await getTemporaryDirectory();
    return [];
  }

  Future<File> _downloadFile(String fileId) async {
    final hikariPod = ref.read(hikariPodProvider);
    final fileBytes = await hikariPod.moduleApi.getFile(fileId);
    final filePath = "$fileId.pdf";
    final file = File("${_appDocDir.path}/$filePath");
    await file.writeAsBytes(fileBytes);
    final pointer = FilePointer(file_id: fileId, path: filePath);
    final currentFiles = state.value ?? [];
    state = AsyncValue.data([...currentFiles, pointer]);
    return file;
  }

  Future<File?> _cachedFile(String fileId) async {
    final currentFiles = state.value ?? [];

    final pointer = currentFiles.firstWhereOrNull(
      (file) => file.file_id == fileId,
    );
    if (pointer == null) return null;

    // check if path is still valid
    final path = "${_appDocDir.path}/${pointer.path}";
    final file = File(path);

    if (!await file.exists()) {
      // File is not valid, remove from cache
      currentFiles.remove(pointer);
      state = AsyncValue.data(currentFiles);
      return null;
    }

    return file;
  }

  Future<File> loadFile(String fileId) async {
    final cachedFile = await _cachedFile(fileId);

    if (cachedFile != null) {
      return cachedFile;
    }

    return await _downloadFile(fileId);
  }
}
