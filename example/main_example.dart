import 'package:latex_table/latex_table.dart';

/// This is the example from the README. A scientific table with two left
/// aligned columns. The values in the second column are suffixed by a € symbol.

void main() {
  var table = Table(
    columnDefinitions: [LeftAlignedColumn(), LeftAlignedColumn()],
    rows: [
      Rule(),
      DataRow(fields: [Field(value: 'Item'), Field(value: 'Costs')]),
      Rule(),
      DataRow(fields: [Field(value: 'Food'), EuroField(value: '150.98')]),
      DataRow(fields: [Field(value: 'Rent'), EuroField(value: '1223.23')]),
      Rule(),
    ],
  );

  Result result = parseTable(table);

  if (result is Success) {
    print(result.value);
  }
}

/// This returns the following LaTeX source code:
/// 
/// ```latex
///  \begin{tabular}{ll}
///   \toprule
///   Item & Costs         \\
///   \midrule
///   Food & \EUR{150.98}  \\
///   Rent & \EUR{1223.23} \\
///   \bottomrule
/// \end{tabular}
/// ```