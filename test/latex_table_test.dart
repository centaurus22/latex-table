import 'package:latex_table/latex_table.dart';
import 'package:test/test.dart';

void main() {
  group('latex generation tests', () {
    test('generating base table', () {
      var table = Table(fieldDefinitions: [CenteredField()], rows: []);
      var result = '\\begin{tabular}{c}\n\\end{tabular}';
      expect(generateTable(table), result);
    });
    test('whether error is thrown when no field is defined', () {
      var table = Table(fieldDefinitions: [], rows: []);
      expect(()=> generateTable(table), throwsFormatException);
    });
  });
}
