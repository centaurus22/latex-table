# Examples

A few usage examples for `latex_table`.

## Base example

This is the example from the README. A scientific table with two left
aligned columns. The values in the second column are suffixed by a € symbol.

```dart
import 'package:latex_table/latex_table.dart';

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
```

This returns the following LaTeX source code:

```latex
\begin{tabular}{ll}
  \toprule
  Item & Costs         \\
  \midrule
  Food & \EUR{150.98}  \\
  Rent & \EUR{1223.23} \\
  \bottomrule
\end{tabular}
```

## Error example

Error example: A table must contain a least one column. This information
is wrapped in the Error object.

```dart
import 'package:latex_table/latex_table.dart';

void main() {
  var table = Table(
    columnDefinitions: [],
    rows: [],
  );

  Result result = parseTable(table);

  if (result is Error) {
    print(result.message);
  }
}
```

## Warning example

Warning example: If the number of columns in the row list differs from the
number of columns in the columnDefinitions list warnings are added to
Success object. The Error object does not contain warnings to save a few
CPU cycles.

```dart
import 'package:latex_table/latex_table.dart';

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
```

The following warnings are emitted: `[Row 3 has too many cells., Row 4 has too few cells.]`.

This also returns the following LaTeX source code:

```latex
\begin{tabular}{ll}
  \toprule
  Item & Costs      \\
  \midrule
  Food & Vegetables & \EUR{150.98} \\
  Rent \\
  \bottomrule
\end{tabular}
```
