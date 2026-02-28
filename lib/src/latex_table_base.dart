import 'analyze.dart';
import 'parse.dart';
import 'record.dart';

/// API function to transfer a [Table] into the latex source code of a table.
///
/// Basically it returns an [Error] if the latex compiler would throw also
/// an error. Otherwise a [Success] is returned. If the structure is
/// malformed in other ways, it adds warnings to the [Result].
///
/// * It returns an [Error] if no column is defined.
/// * It adds warnings if the number of columns in a data row differs from the
///   the number of columns in the column definitions.
Result parseTable(Table table) {
  var result = analyze(table);

  if (result is Success) {
    List<int> columnWidths = result.value;

    return Success(
      value: parse(table, columnWidths),
      warnings: result.warnings,
    );
  }

  return result;
}
