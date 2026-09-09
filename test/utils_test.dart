import 'package:amsl_app/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('generateInterruptedMulti', () {
    List<List<int>> rowsOf(List<String> result) {
      // filler entries are 'F', row entries are 'R:<items>'
      return result
          .where((e) => e.startsWith('R:'))
          .map((e) => e.substring(2).split(',').map(int.parse).toList())
          .toList();
    }

    List<String> run(List<int> items, int perRow) {
      return generateInterruptedMulti<int, String>(
        items,
        (chunk, _, _) => 'R:${chunk.join(',')}',
        'F',
        perRow: perRow,
      );
    }

    test('does not throw when list length exceeds a small multiple of perRow', () {
      final result = run(List.generate(6, (i) => i), 2);
      expect(rowsOf(result), [
        [0, 1],
        [2, 3],
        [4, 5],
      ]);
    });

    test('handles a list length not evenly divisible by perRow', () {
      final result = run(List.generate(5, (i) => i), 2);
      expect(rowsOf(result), [
        [0, 1],
        [2, 3],
        [4],
      ]);
    });

    test('inserts exactly one filler between rows', () {
      final result = run(List.generate(4, (i) => i), 2);
      expect(result, ['R:0,1', 'F', 'R:2,3']);
    });

    test('handles an empty list', () {
      expect(run([], 2), <String>[]);
    });
  });
}
