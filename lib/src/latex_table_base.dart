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
        '${_data(table.rows, table.columnDefinitions.length)}'
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

String _data(List<Row> rows, int numberColumns) {
  List<int> columnWidths = rows.fold(
    List.filled(numberColumns, 0, growable: false),
    (currentLengths, row) =>
        _updateColumWidthsByRow(currentLengths, row, numberColumns),
  );

  return rows.fold('', (rows, row) => rows + _row(row, columnWidths));
}

List<int> _updateColumWidthsByRow(
  List<int> columnWidths,
  Row row,
  int numberColumns,
) {
  switch (row) {
    case DataRow _:
      return _updateColumWidthsByDataRow(
        columnWidths,
        row.fields,
        numberColumns,
      );
    default:
      return columnWidths;
  }
}

List<int> _updateColumWidthsByDataRow(
  List<int> columnWidths,
  List<Field> fields,
  int numberColumns,
) {
  var numberFields = fields.length;

  for (var n = 0; n < numberFields; n++) {
    if (n > numberColumns) {
      break;
    }
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

  if (columnWidths[fieldIndex] < columnWidth) {
    columnWidths[fieldIndex] = columnWidth;
  }

  return columnWidths;
}

String _row(Row row, List<int> columnLengths) {
  switch (row) {
    case DataRow _:
      return '${_dataRow(row.fields, columnLengths)}\n';
    case TopRule _:
      return '  \\toprule\n';
    case MidRule _:
      return '  \\midrule\n';
    case BottomRule _:
      return '  \\bottomrule\n';
  }
}

String _dataRow(List<Field> fields, List<int> columnLengths) {
  var numberFields = fields.length;
  var fieldsString = ' ';
  const doubleBackSlash = '\\';

  for (var n = 0; n < numberFields; n++) {
    var fieldString = _field(fields[n], columnLengths[n]);
    if (n == numberFields - 1) {
      fieldsString += ' $fieldString$doubleBackSlash';
    } else {
      fieldsString += ' $fieldString &';
    }
  }
  return fieldsString;
}

String _field(Field field, int columnLength) {
  var fieldString = field.value;

  if (field is EuroField) {
    fieldString = '\\EUR{$fieldString}';
  }

  return fieldString.padRight(columnLength);
}
