import 'package:latex_table/latex_table.dart';
import 'package:test/test.dart';

void main() {
  group('latex generation tests', () {
    test('generating base table', () {
      var result = generateLatexTable(
        Table(columnDefinitions: [CenteredColumn()], rows: []),
      );
      var value = '\\begin{tabular}{c}\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('whether error is returned when no column is defined', () {
      var error = generateLatexTable(Table(columnDefinitions: [], rows: []));
      expect(error.runtimeType, Error);
      if (error is Error) {
        expect(error.message.isNotEmpty, true);
      }
    });
    test('generating table with left aligned column', () {
      var result = generateLatexTable(
        Table(columnDefinitions: [LeftAlignedColumn()], rows: []),
      );
      var value = '\\begin{tabular}{l}\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating table with two columns', () {
      var result = generateLatexTable(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [],
        ),
      );
      var value = '\\begin{tabular}{lr}\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
  });
}
