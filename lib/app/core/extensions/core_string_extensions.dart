extension CoreStringExtensions on String {
  String truncateTo(int maxLength) {
    return (length <= maxLength) ? this : '${substring(0, maxLength)}...';
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
