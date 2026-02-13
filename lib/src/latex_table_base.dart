import 'package:latex_table/latex_table.dart';

/// API function to transfer a [Table] into the latex source code of a table.
/// 
/// Basically it returns an [Error] if the latex compiler would throw also
/// an error. Otherwise a [Success] is returned. If the structure is
/// malformed in other ways, it adds warnings to the [Result].
/// 
/// * It returns an [Error] if no column is defined.
Result parse(Table table) {
  if (table.columnDefinitions.isEmpty) {
    return Error(message: 'The table must have at least one column.');
  }

  return Success(
    value:
        '\\begin{tabular}{${_alignmentCodes(table.columnDefinitions)}}\n'
        '${_data(table.rows)}'
        '\\end{tabular}',
  );
}

String _alignmentCodes(List<ColumnDefinition> columnDefinitions) {
  return columnDefinitions.fold(
    '',
    (codes, columnDefinition) => codes + _alignmentCode(columnDefinition),
  );
}

String _alignmentCode(ColumnDefinition columnDefinition) {
  switch (columnDefinition) {
    case LeftAlignedColumn _:
      return 'l';
    case CenteredColumn _:
      return 'c';
    case RightAlignedColumn _:
      return 'r';
  }
}

String _data(List<Row> rows) {
  return rows.fold(
    '',
    (rows, row) => rows + _row(row),
  );
}

String _row(Row row) {
  switch(row) {
    case DataRow _:
      return '${_dataRow(row.fields)}\n';
    default:
      return '';
  }
}

String _dataRow(List<Field> fields) {
  var numberFields = fields.length;
  var fieldsString = ' ';
  const doubleBackSlash = '\\';

  for (var n = 0; n < numberFields; n++) {
    if (n == numberFields - 1) {
      fieldsString += ' ${fields[n].value}$doubleBackSlash';
    } else {
      fieldsString += ' ${fields[n].value} &';
    }
  }
  return fieldsString;
}
