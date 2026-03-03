import 'package:latex_table/src/latex_table_base.dart';
import 'package:latex_table/src/record.dart';

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
