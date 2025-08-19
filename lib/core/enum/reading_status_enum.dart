enum ReadingStatus {
  toRead('To Read'),
  reading('Reading'),
  finished('Finished');

  const ReadingStatus(this.displayName);

  final String displayName;

  static ReadingStatus fromString(String value) {
    return ReadingStatus.values.firstWhere(
      (status) => status.displayName == value,
      orElse: () => ReadingStatus.toRead,
    );
  }
}
