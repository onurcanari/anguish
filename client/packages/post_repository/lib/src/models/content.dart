abstract class Content {
  Content(this.id, this.text);

  final int id;
  final String text;
}

class Tag extends Content {
  Tag(int id, String text) : super(id, text);
}

class PresetText extends Content {
  PresetText(int id, String text) : super(id, text);
}
