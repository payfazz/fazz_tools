class PrintOptions {
  String color;
  String prefix;
  String suffix;
  bool showTimestamp;

  PrintOptions({
    this.color,
    this.prefix,
    this.suffix,
    this.showTimestamp = true,
  });
}
