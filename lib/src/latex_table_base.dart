import 'package:latex_table/latex_table.dart';

Result generateTable(Table table) {
  if (table.columnDefinitions.isEmpty) {
    return Error(message: 'The table must have at least one column.');
  }

  switch (table.columnDefinitions.first) {
    case LeftAlignedColumn():
      return Success(value: '\\begin{tabular}{l}\n\\end{tabular}');
    case CenteredColumn():
      return Success(value: '\\begin{tabular}{c}\n\\end{tabular}');
    case RightAlignedColumn():
      return Success(value: '\\begin{tabular}{r}\n\\end{tabular}');
  }
}
