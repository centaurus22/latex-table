import 'record.dart';

Result analyse(Table table) {
  if (table.columnDefinitions.isEmpty) {
    return Error(
      message: 'The table must have at least one column.',
      warnings: [],
    );
  }

  var rows = table.rows;
  var numberColumns = table.columnDefinitions.length;
  var numberRows = rows.length;
  var analyseResult = AnalyseResult(
    columnWidths: List.filled(numberColumns, 0, growable: true),
    warnings: [],
  );

  for (var n = 0; n < numberRows; n++) {
    analyseResult = _updateColumWidthsByRow(
      analyseResult,
      rows[n],
      numberColumns,
      n,
    );
  }

  return Success(
    value: analyseResult.columnWidths,
    warnings: analyseResult.warnings,
  );
}

AnalyseResult _updateColumWidthsByRow(
  AnalyseResult analyseResult,
  Row row,
  int numberColumns,
  int rowIndex,
) {
  switch (row) {
    case DataRow _:
      return _updateColumWidthsByDataRow(
        analyseResult,
        row.fields,
        numberColumns,
        rowIndex,
      );
    default:
      return analyseResult;
  }
}

AnalyseResult _updateColumWidthsByDataRow(
  AnalyseResult analyseResult,
  List<Field> fields,
  int numberColumns,
  int rowIndex,
) {
  var numberFields = fields.length;

  if (numberFields > numberColumns) {
    analyseResult.warnings.add('Row ${rowIndex + 1} has to much cells.');
  }

  for (var n = 0; n < numberFields; n++) {
    analyseResult = _updateColumWidthsByField(analyseResult, fields, n);
  }

  return analyseResult;
}

AnalyseResult _updateColumWidthsByField(
  AnalyseResult analyseResult,
  List<Field> fields,
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

  if (analyseResult.columnWidths.length < fieldIndex + 1) {
    analyseResult.columnWidths.add(columnWidth);
  } else if (analyseResult.columnWidths[fieldIndex] < columnWidth) {
    analyseResult.columnWidths[fieldIndex] = columnWidth;
  }

  return analyseResult;
}
