import 'package:latex_table/latex_table.dart';
import 'package:test/test.dart';

void main() {
  const doubleBackSlash = '\\';
  group('latex generation tests', () {
    test('generating base table', () {
      var result = parse(
        Table(columnDefinitions: [CenteredColumn()], rows: []),
      );
      var value = '\\begin{tabular}{c}\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('whether error is returned when no column is defined', () {
      var error = parse(Table(columnDefinitions: [], rows: []));
      expect(error.runtimeType, Error);
      if (error is Error) {
        expect(error.message.isNotEmpty, true);
      }
    });
    test('generating table with left aligned column', () {
      var result = parse(
        Table(columnDefinitions: [LeftAlignedColumn()], rows: []),
      );
      var value = '\\begin{tabular}{l}\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating table with two columns', () {
      var result = parse(
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
    test('generating table with one data cell', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn()],
          rows: [DataRow(fields: [Field(value: "Name")])],
        ),
      );
      var value = '\\begin{tabular}{l}\n  Name$doubleBackSlash\n\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating table with two rows', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn()],
          rows: [
            DataRow(fields: [Field(value: "Name")]),
            DataRow(fields: [Field(value: "Klaus")])
          ],
        ),
      );
      var value = '\\begin{tabular}{l}\n'
        '  Name$doubleBackSlash\n'
        '  Klaus$doubleBackSlash\n'
        '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating rows with two fields', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn()],
          rows: [
            DataRow(fields: [Field(value: "Name"), Field(value: "Klaus")]),
            DataRow(fields: [Field(value: "Name"), Field(value: "Stefan")])
          ],
        ),
      );
      var value = '\\begin{tabular}{l}\n'
        '  Name & Klaus$doubleBackSlash\n'
        '  Name & Stefan$doubleBackSlash\n'
        '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
  });
}
