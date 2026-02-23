import 'analyse.dart';
import 'parse.dart';
import 'record.dart';

/// API function to transfer a [Table] into the latex source code of a table.
///
/// Basically it returns an [Error] if the latex compiler would throw also
/// an error. Otherwise a [Success] is returned. If the structure is
/// malformed in other ways, it adds warnings to the [Result].
///
/// * It returns an [Error] if no column is defined.
Result parse(Table table) {
  var result = analyse(table);

  if (result is Success) {
    List<int> columnWidths = result.value;

    return Success(
      value:
          '\\begin{tabular}{${parseColumns(table.columnDefinitions)}}\n'
          '${parseData(table.rows, columnWidths)}'
          '\\end{tabular}',
      warnings: result.warnings,
    );
  }

  return result;
}
