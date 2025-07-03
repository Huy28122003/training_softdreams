abstract class UncompressDelegate {
  const UncompressDelegate();

  String get extension;

  Future uncompress(
    String compressedFilePath,
    String outputDir, [
    bool extractHere = true,
  ]);
}
