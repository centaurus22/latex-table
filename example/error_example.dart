import 'package:latex_table/latex_table.dart';

/// Error example: A table must contain a least one column. This information
/// is wrapped in the [Error] object.

void main() {
  var table = Table(
    columnDefinitions: [],
    rows: [],
  );

  Result result = parseTable(table);

  if (result is Error) {
    print(result.message);
  }
}
