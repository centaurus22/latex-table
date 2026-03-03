import 'package:latex_table/src/latex_table_base.dart';
import 'package:latex_table/src/record.dart';

/// Warning example: If the number of columns in the row list differs from the
/// number of columns in the columnDefinitions list warnings are added to
/// [Success] object. The [Error] object do not contain warnings to safe a few
/// CPU cycles.

void main() {
  var table = Table(
    columnDefinitions: [LeftAlignedColumn(), LeftAlignedColumn()],
    rows: [
      Rule(),
      DataRow(
        fields: [
          Field(value: 'Item'),
          Field(value: 'Costs'),
        ],
      ),
      Rule(),
      DataRow(
        fields: [
          Field(value: 'Food'),
          Field(value: 'Vegetables'),
          EuroField(value: '150.98'),
        ],
      ),
      DataRow(fields: [Field(value: 'Rent')]),
      Rule(),
    ],
  );

  Result result = parseTable(table);

  if (result is Success) {
    print(result.warnings);
    print(result.value);
  }
}

/// The following warnings are emitted:
/// `[Row 3 has too many cells., Row 4 has too few cells.]`
///
/// This also returns the following LaTeX source code:
///
/// ```latex
/// \begin{tabular}{ll}
///   \toprule
///   Item & Costs      \\
///   \midrule
///   Food & Vegetables & \EUR{150.98} \\
///   Rent \\
///   \bottomrule
/// \end{tabular}
/// ```
