

A Dart library to parse an object structure to LaTeX source code for a simple
table.

The object structure can be easily generated programmatically.

## License

This work is provided under the terms of the MIT license. Please take a look at
the LICENSE file for the full text.

## Features

* Supports left aligned, right aligned and centered columns.
* Generates LaTeX sources for a scientific table: If the first row is rule, it
  is converted to a `\toprule`. If the last row is a rule it is converted to a
  `\bottomrule`. Every other rule is converted to a `\midrule`.
* Supports a special table field for values ​​with currency specifications in
  Euros.
* Returns an error if the LaTeX parser won't compile the LaTeX source,
* Returns warnings if the number of columns differs from the number of fields in
  a data row.
* And last but not least: Columns are nicely aligned :)

If you need any feature please [contact](#contact) me.

## Usage
The following Dart record structure
```dart
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
```
will be converted into this LaTeX source code by `parse(table)` :

```latex
\begin{tabular}{ll}
  \toprule
  Item      & Costs         \\
  \midrule
  Food      & \EUR{150.98}  \\
  Rent      & \EUR{1223.23} \\
  \bottomrule
\end{tabular}
```

## Contact

If you have any questions just drop a message at mail@centaurus22.de.