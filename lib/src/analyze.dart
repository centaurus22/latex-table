import 'record.dart';

Result analyze(Table table) {
  if (table.columnDefinitions.isEmpty) {
    return Error(
      message: 'The table must have at least one column.',
      warnings: [],
    );
  }

  var rows = table.rows;
  var numberColumns = table.columnDefinitions.length;
  var numberRows = rows.length;
  var analyzeResult = AnalyzeResult(
    columnWidths: List.filled(numberColumns, 0, growable: true),
    warnings: [],
  );

  for (var n = 0; n < numberRows; n++) {
    analyzeResult = _updateColumWidthsByRow(
      analyzeResult,
      rows[n],
      numberColumns,
      n,
    );
  }

  return Success(
    value: analyzeResult.columnWidths,
    warnings: analyzeResult.warnings,
  );
}

AnalyzeResult _updateColumWidthsByRow(
  AnalyzeResult analyzeResult,
  Row row,
  int numberColumns,
  int rowIndex,
) {
  switch (row) {
    case DataRow _:
      return _updateColumWidthsByDataRow(
        analyzeResult,
        row.fields,
        numberColumns,
        rowIndex,
      );
    default:
      return analyzeResult;
  }
}

AnalyzeResult _updateColumWidthsByDataRow(
  AnalyzeResult analyzeResult,
  List<Field> fields,
  int numberColumns,
  int rowIndex,
) {
  var numberFields = fields.length;

  if (numberFields > numberColumns) {
    analyzeResult.warnings.add('Row ${rowIndex + 1} has too many cells.');
  } else if (numberFields < numberColumns) {
    analyzeResult.warnings.add('Row ${rowIndex + 1} has too few cells.');
  }

  for (var n = 0; n < numberFields; n++) {
    analyzeResult = _updateColumWidthsByField(analyzeResult, fields, n);
  }

  return analyzeResult;
}

AnalyzeResult _updateColumWidthsByField(
  AnalyzeResult analyzeResult,
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

  if (analyzeResult.columnWidths.length < fieldIndex + 1) {
    analyzeResult.columnWidths.add(columnWidth);
  } else if (analyzeResult.columnWidths[fieldIndex] < columnWidth) {
    analyzeResult.columnWidths[fieldIndex] = columnWidth;
  }

  return analyzeResult;
}
