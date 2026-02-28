import 'record.dart';

String parse(Table table, List<int> columnWidths) {
  return '\\begin{tabular}{${_parseColumns(table.columnDefinitions)}}\n'
      '${_parseData(table.rows, columnWidths)}'
      '\\end{tabular}';
}

String _parseColumns(List<ColumnDefinition> columnDefinitions) {
  return columnDefinitions.fold(
    '',
    (codes, columnDefinition) => codes + _parseColumn(columnDefinition),
  );
}

String _parseColumn(ColumnDefinition columnDefinition) {
  switch (columnDefinition) {
    case LeftAlignedColumn _:
      return 'l';
    case CenteredColumn _:
      return 'c';
    case RightAlignedColumn _:
      return 'r';
  }
}

String _parseData(List<Row> rows, List<int> columnWidths) {
  var rowsString = '';
  var numberRows = rows.length;
  for (var n = 0; n < numberRows; n++) {
    rowsString += '${_parseRow(rows[n], columnWidths, numberRows, n)}\n';
  }
  return rowsString;
}

String _parseRow(
  Row row,
  List<int> columnWidths,
  int numberRows,
  int rowIndex,
) {
  switch (row) {
    case DataRow _:
      return _parseDataRow(row.fields, columnWidths);
    case Rule _:
      if (rowIndex == 0) {
        return '  \\toprule';
      } else if (rowIndex == numberRows - 1) {
        return '  \\bottomrule';
      } else {
        return '  \\midrule';
      }
  }
}

String _parseDataRow(List<Field> fields, List<int> columnWidths) {
  var numberFields = fields.length;
  var fieldsString = ' ';
  const doubleBackSlash = '\\\\';

  for (var n = 0; n < numberFields; n++) {
    var fieldString = _parseField(fields, n).padRight(columnWidths[n]);
    if (n >= numberFields - 1) {
      fieldsString += ' $fieldString';
    } else {
      fieldsString += ' $fieldString &';
    }
  }
  return '$fieldsString $doubleBackSlash';
}

String _parseField(List<Field> fields, int fieldIndex) {
  var field = fields[fieldIndex];
  var value = field.value;

  if (field is EuroField) {
    return '\\EUR{$value}';
  }

  return value;
}
