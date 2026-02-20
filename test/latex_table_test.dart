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
          rows: [
            DataRow(fields: [Field(value: "Name")]),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{l}\n  Name $doubleBackSlash\n\\end{tabular}';
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
            DataRow(fields: [Field(value: "Klaus")]),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{l}\n'
          '  Name  $doubleBackSlash\n'
          '  Klaus $doubleBackSlash\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating rows with two fields', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [
            DataRow(
              fields: [
                Field(value: "Name"),
                Field(value: "Klaus"),
              ],
            ),
            DataRow(
              fields: [
                Field(value: "Name"),
                Field(value: "Stefan"),
              ],
            ),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{lr}\n'
          '  Name & Klaus  $doubleBackSlash\n'
          '  Name & Stefan $doubleBackSlash\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating fields with variable lengths', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [
            DataRow(
              fields: [
                Field(value: "Name"),
                Field(value: "MegaSoftware"),
              ],
            ),
            DataRow(
              fields: [
                Field(value: "Version"),
                Field(value: "3.4.2"),
              ],
            ),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{lr}\n'
          '  Name    & MegaSoftware $doubleBackSlash\n'
          '  Version & 3.4.2        $doubleBackSlash\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating toprule', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [
            Rule(),
            DataRow(
              fields: [
                Field(value: "Version"),
                Field(value: "3.4.2"),
              ],
            ),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{lr}\n'
          '  \\toprule\n'
          '  Version & 3.4.2 $doubleBackSlash\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating bottomrule', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [
            DataRow(
              fields: [
                Field(value: "Version"),
                Field(value: "3.4.2"),
              ],
            ),
            Rule(),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{lr}\n'
          '  Version & 3.4.2 $doubleBackSlash\n'
          '  \\bottomrule\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating midrule', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [
            DataRow(
              fields: [
                Field(value: "Name"),
                Field(value: "Value"),
              ],
            ),
            Rule(),
            DataRow(
              fields: [
                Field(value: "Version"),
                Field(value: "3.4.2"),
              ],
            ),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{lr}\n'
          '  Name    & Value $doubleBackSlash\n'
          '  \\midrule\n'
          '  Version & 3.4.2 $doubleBackSlash\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
    test('generating midrule', () {
      var result = parse(
        Table(
          columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
          rows: [
            Rule(),
            DataRow(
              fields: [
                Field(value: "Position"),
                Field(value: "Amount"),
              ],
            ),
            Rule(),
            DataRow(
              fields: [
                Field(value: "01"),
                EuroField(value: "15"),
              ],
            ),
            Rule(),
          ],
        ),
      );
      var value =
          '\\begin{tabular}{lr}\n'
          '  \\toprule\n'
          '  Position & Amount   $doubleBackSlash\n'
          '  \\midrule\n'
          '  01       & \\EUR{15} $doubleBackSlash\n'
          '  \\bottomrule\n'
          '\\end{tabular}';
      expect(result.runtimeType, Success);
      if (result is Success) {
        expect(result.value, value);
      }
    });
  });
  test('one missing cell', () {
    var result = parse(
      Table(
        columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
        rows: [
          DataRow(
            fields: [
              Field(value: "Position"),
              Field(value: "Amount"),
            ],
          ),
          DataRow(fields: [Field(value: "01")]),
        ],
      ),
    );
    var value =
        '\\begin{tabular}{lr}\n'
        '  Position & Amount $doubleBackSlash\n'
        '  01       $doubleBackSlash\n'
        '\\end{tabular}';
    expect(result.runtimeType, Success);
    if (result is Success) {
      expect(result.value, value);
    }
  });
  test('all cells missing', () {
    var result = parse(
      Table(
        columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
        rows: [
          DataRow(
            fields: [
              Field(value: "Position"),
              Field(value: "Amount"),
            ],
          ),
          DataRow(fields: []),
        ],
      ),
    );
    var value =
        '\\begin{tabular}{lr}\n'
        '  Position & Amount $doubleBackSlash\n'
        '  $doubleBackSlash\n'
        '\\end{tabular}';
    expect(result.runtimeType, Success);
    if (result is Success) {
      expect(result.value, value);
    }
  });
  test('one cell to much', () {
    var result = parse(
      Table(
        columnDefinitions: [LeftAlignedColumn(), RightAlignedColumn()],
        rows: [
          DataRow(
            fields: [
              Field(value: "Position"),
              Field(value: "Amount"),
            ],
          ),
          DataRow(
            fields: [
              Field(value: "01"),
              EuroField(value: "15"),
              EuroField(value: "23"),
            ],
          ),
        ],
      ),
    );
    var value =
        '\\begin{tabular}{lr}\n'
        '  Position & Amount   $doubleBackSlash\n'
        '  01       & \\EUR{15} & \\EUR{23} $doubleBackSlash\n'
        '\\end{tabular}';
    expect(result.runtimeType, Success);
    if (result is Success) {
      expect(result.value, value);
    }
  });
}
