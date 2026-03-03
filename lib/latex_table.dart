/// A Dart library to parse an object structure to LaTeX source code for a simple
/// table.
///
/// The object structure can be easily generated programmatically.
/// 
/// Features:
/// * Supports left aligned, right aligned and centered columns.
/// * Generates LaTeX sources for a scientific table: If the first row is rule,
///   it is converted to a `\toprule`. If the last row is a rule it is converted
///   to a `\bottomrule`. Every other rule is converted to a `\midrule`.
/// * Supports a special table field for values ​​with currency specifications in
///   Euros.
/// * Returns an error if the LaTeX parser won't compile the LaTeX source,
/// * Returns warnings if the number of columns differs from the number of
///   fields in a data row.
/// * And last but not least: Columns are nicely aligned :)
///
/// If you need any feature please [contact](#contact) me.

library;

export 'src/latex_table_base.dart';
export 'src/record.dart';
