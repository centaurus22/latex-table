import 'package:latex_table/latex_table.dart';

Result generateTable(Table table) {
  if (table.columnDefinitions.isEmpty) {
    throw FormatException('The table must have at least one column.');
  }
  return Success(value: '\\begin{tabular}{c}\n\\end{tabular}');
}
