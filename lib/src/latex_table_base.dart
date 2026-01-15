
import 'package:latex_table/latex_table.dart';

String generateTable(Table table) {
  if(table.columnDefinitions.isEmpty) {
    throw FormatException('The table must have at least one column.');
  }
  return '\\begin{tabular}{c}\n\\end{tabular}';
}