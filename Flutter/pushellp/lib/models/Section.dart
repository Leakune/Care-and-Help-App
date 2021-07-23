class Section {
  final int idSection;
  final String title;
  final String description;
  final String? srcicon;

  Section({required this.idSection, required this.title, required this.description, this.srcicon});

  factory Section.fromJson(Map<String, dynamic> json){
    int id = json['idsection'];
    String title = json['title'];
    String srcicon = json['srcicon'] != null ? json['srcicon'] : "";
    String description = json['description'];
    return Section(
      idSection: id,
      title: title,
      description: description,
      srcicon: srcicon
    );
  }

  
  String toString() {
    return "Section(id: $idSection, title: $title, description: $description, srcicon: $srcicon)";
  }
}
