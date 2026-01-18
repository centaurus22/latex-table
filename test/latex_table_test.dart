import 'package:latex_table/latex_table.dart';
import 'package:test/test.dart';

void main() {
  group('latex generation tests', () {
    test('generating base table', () {
      var result = generateTable(Table(columnDefinitions: [CenteredColumn()], rows: []));
      var value = '\\begin{tabular}{c}\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('whether error is thrown when no field is defined', () {
      var table = Table(columnDefinitions: [], rows: []);
      expect(() => generateTable(table), throwsFormatException);
    });
  });
}
