import 'record.dart';

Result analyse(Table table) {
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
