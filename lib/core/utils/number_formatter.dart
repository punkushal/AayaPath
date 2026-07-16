// -----------------------------------------------------------------------
// Number formatting helpers for the AayaPath app.
//
// Nepal (like the rest of South Asia) groups digits as: last 3 digits,
// then groups of 2 going left — e.g. 1500000 -> "15,00,000" — rather than
// the Western "1,500,000" grouping. This mirrors the figures shown in the
// Income Information screen ("Rs. 1,25,000" / "Rs. 15,00,000").
// -----------------------------------------------------------------------

class NumberFormatter {
  NumberFormatter._();

  /// Formats [value] using South Asian ("lakh/crore") digit grouping.
  static String nepaliGrouped(num value) {
    final isNegative = value < 0;
    final digits = value.abs().round().toString();
    if (digits.length <= 3) return '${isNegative ? '-' : ''}$digits';

    final lastThree = digits.substring(digits.length - 3);
    final rest = digits.substring(0, digits.length - 3);

    final buffer = StringBuffer();
    for (var i = 0; i < rest.length; i++) {
      final remaining = rest.length - i;
      if (i > 0 && remaining % 2 == 0) buffer.write(',');
      buffer.write(rest[i]);
    }

    return '${isNegative ? '-' : ''}$buffer,$lastThree';
  }

  /// Formats [value] as a rupee figure, e.g. "Rs. 1,25,000".
  static String rupees(num value) => 'Rs. ${nepaliGrouped(value)}';
}
