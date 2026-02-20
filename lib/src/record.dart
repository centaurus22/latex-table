/// The starting point of the structure that will be converted.
///
/// It contains the data and the structure of the latex table.
class Table {
  /// A list of column definitions.
  ///
  /// A [ColumnDefinition] defines if a column is left aligned, centered
  /// or right aligned.
  final List<ColumnDefinition> columnDefinitions;

  /// A list of rows.
  ///
  /// Rows can contain either data fields or simply represent a horizontal
  /// line in various forms.
  final List<Row> rows;

  /// Requires the [columnDefinitions] and the [rows].
  ///
  /// The parser returns an [Error] if the [columnDefinitions] list is empty.
  Table({required this.columnDefinitions, required this.rows});
}

/// The definition of one column.
///
/// This is the sealed base class. It can either be a [LeftAlignedColumn],
/// a [CenteredColumn] or a [RightAlignedColumn].
sealed class ColumnDefinition {}

/// This represents a column which content is aligned to the left.
class LeftAlignedColumn extends ColumnDefinition {}

/// This represents a column which content is centered.
class CenteredColumn extends ColumnDefinition {}

/// This represents a column which content is aligned to the right.
class RightAlignedColumn extends ColumnDefinition {}

/// This represents a row in the table.
///
/// This is the sealed base class.
/// It can either be a [DataRow] that contains [Field]s with information
/// or header, or a [Rule] for the various styles of horizontal lines in
/// scientific tables.
sealed class Row {}

/// The horizontal line in a scientific table.
///
/// It is converted to the `\toprule`, the `\midrule` or the `\bottomrule`
/// command depending on its position in the table.
///
/// The sealed base class is the [Row]. The other row-like objects is the
/// [DataRow] that contains [Field]s with data or header.
class Rule extends Row {}

/// A row of table data or header.
///
/// The sealed base class is the [Row]. The other rows is the [Rule] for the various
/// styles of horizontal lines in a scientific tables.
class DataRow extends Row {
  /// A [List] of [Field]s in one row.
  ///
  /// The list contains the data or headers of a table.
  final List<Field> fields;

  /// This requires the [fields].
  DataRow({required this.fields});
}

/// This contains a table datum or header.
///
/// A special [Field] is the [EuroField].
class Field {
  /// The value of the field.
  final String value;

  /// This requires the [value] of the [Field].
  Field({required this.value});
}

/// This [Field] is for currency values in Euro.
///
/// In the generated Latex table this value will be used as a parameter for
/// the EUR command from the eurosym package for LATEX. This ads a € symbol
/// to your value together with a unbreakable thin space in between.
///
/// The base object [Field] contains just normal data or header.
class EuroField extends Field {
  /// This requires the [value] of the [Field].
  EuroField({required super.value});
}

/// A result of a function which can be a [Success] or an [Error].
///
/// This is the sealed base class. Its children are used in functions that can
/// return an [Error] instead of a of an expected value ([Success])
/// or additional [warnings].
sealed class Result {
  /// A list of warnings.
  final List<String> warnings = [];
}

/// This is returned when functions are executed correctly.
///
/// It can contain additional [warnings].
/// The sealed base class is the [Result]. The other [Result] ist a [Error].
class Success extends Result {
  /// The embedded value.
  final dynamic value;

  /// This requires the embedded [value].
  Success({required this.value});
}

/// This is returned when a parameter is not valid.
///
/// It can contain additional [warnings].
/// The sealed base class ist the [Result]. The other [Result] ist a [Success].
/// when the function executed correctly.
class Error extends Result {
  /// The error message.
  final String message;

  /// This requires the error [message].
  Error({required this.message});
}
