
import 'package:latex_table/latex_table.dart';

String generateTable(Table table) {
  if(table.fieldDefinitions.isEmpty) {
    throw FormatException('The table needs at least on column.');
  }
  return '\\begin{tabular}{c}\n\\end{tabular}';
}