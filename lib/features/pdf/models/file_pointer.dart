import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_pointer.freezed.dart';

@freezed
abstract class FilePointer with _$FilePointer {
  const factory FilePointer({required String file_id, required String path}) =
      _FilePointer;
}
