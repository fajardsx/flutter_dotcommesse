class SaveResponse {
  final String message;

  SaveResponse({
    required this.message,
  });
  factory SaveResponse.fromJson(Map<String, dynamic> json) =>
      SaveResponse(message: json["message"]);
}