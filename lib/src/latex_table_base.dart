import 'package:latex_table/latex_table.dart';

Result generateTable(Table table) {
  if (table.columnDefinitions.isEmpty) {
    return Error(message: 'The table must have at least one column.');
  }

  return Success(
    value: '\\begin{tabular}{${_alignmentCode(table.columnDefinitions.first)}}\n\\end{tabular}',
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
