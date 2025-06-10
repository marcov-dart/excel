part of excel;

Archive _cloneArchive(
  Archive archive,
  Map<String, ArchiveFile> _archiveFiles, {
  String? excludedFile,
}) {
  final clone = Archive();

  archive.files.forEach((file) {
    if (file.isFile) {
      if (excludedFile != null &&
          file.name.toLowerCase() == excludedFile.toLowerCase()) {
        return;
      }
      ArchiveFile copy;
      if (_archiveFiles.containsKey(file.name)) {
        copy = _archiveFiles[file.name]!;
      } else {
        final content = file.content;
        final noCompress = _noCompression.contains(file.name);
        copy = ArchiveFile(file.name, content.length, content);

        if (noCompress) copy.compression = CompressionType.none;
      }
      clone.addFile(copy);
    }
  });
  return clone;
}
