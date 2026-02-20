import 'package:latex_table/latex_table.dart';

/// API function to transfer a [Table] into the latex source code of a table.
///
/// Basically it returns an [Error] if the latex compiler would throw also
/// an error. Otherwise a [Success] is returned. If the structure is
/// malformed in other ways, it adds warnings to the [Result].
///
/// * It returns an [Error] if no column is defined.
Result parse(Table table) {
  var result = _analyse(table);

  if (result is Success) {
    List<int> columnWidths = result.value;

    return Success(
      value:
          '\\begin{tabular}{${_alignmentCodes(table.columnDefinitions)}}\n'
          '${_parseData(table.rows, columnWidths)}'
          '\\end{tabular}',
    );
  }

  return result;
}

Result _analyse(Table table) {
  if (table.columnDefinitions.isEmpty) {
    return Error(message: 'The table must have at least one column.');
  }

  var numberColumns = table.columnDefinitions.length;
  List<int> columnWidths = table.rows.fold(
    List.filled(numberColumns, 0, growable: true),
    (currentLengths, row) => _updateColumWidthsByRow(currentLengths, row),
  );

  return Success(value: columnWidths);
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

String _parseData(List<Row> rows, List<int> columnWidths) {
  var rowsString = '';
  var numberRows = rows.length;
  for (var n = 0; n < numberRows; n++) {
    rowsString += '${_parseRow(rows[n], columnWidths, numberRows, n)}\n';
  }
  return rowsString;
}

List<int> _updateColumWidthsByRow(List<int> columnWidths, Row row) {
  switch (row) {
    case DataRow _:
      return _updateColumWidthsByDataRow(columnWidths, row.fields);
    default:
      return columnWidths;
  }
}

List<int> _updateColumWidthsByDataRow(
  List<int> columnWidths,
  List<Field> fields,
) {
  var numberFields = fields.length;

  for (var n = 0; n < numberFields; n++) {
    columnWidths = _updateColumWidthsByField(fields, columnWidths, n);
  }

  return columnWidths;
}

List<int> _updateColumWidthsByField(
  List<Field> fields,
  List<int> columnWidths,
  int fieldIndex,
) {
  int columnWidth;
  var field = fields[fieldIndex];

  switch (field) {
    case EuroField _:
      columnWidth = field.value.length + 6;
    default:
      columnWidth = field.value.length;
  }

  if (columnWidths.length < fieldIndex + 1) {
    columnWidths.add(columnWidth);
  } else if (columnWidths[fieldIndex] < columnWidth) {
    columnWidths[fieldIndex] = columnWidth;
  }

  return columnWidths;
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
  const doubleBackSlash = '\\';

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
