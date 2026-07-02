class NoticeModel {
  NoticeModel({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    final title = (json['title'] ??
            json['subject'] ??
            json['heading'] ??
            'Aviso')
        .toString();
    final body = (json['description'] ??
            json['body'] ??
            json['message'] ??
            json['text'] ??
            json['content'] ??
            '')
        .toString();
    return NoticeModel(title: title, body: body);
  }
}
