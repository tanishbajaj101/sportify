import 'dart:convert';

class Chat {
  final String senderName;
  final String senderid;
  final String message;
  final String time;
  Chat({
    required this.senderName,
    required this.senderid,
    required this.message,
    required this.time,
  });

  Chat copyWith({
    String? senderName,
    String? senderid,
    String? message,
    String? time,
  }) {
    return Chat(
      senderName: senderName ?? this.senderName,
      senderid: senderid ?? this.senderid,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderName': senderName,
      'senderid': senderid,
      'message': message,
      'time': time,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      senderName: map['senderName'] ?? '',
      senderid: map['senderid'] ?? '',
      message: map['message'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chat(senderName: $senderName, senderid: $senderid, message: $message, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.senderName == senderName &&
        other.senderid == senderid &&
        other.message == message &&
        other.time == time;
  }

  @override
  int get hashCode {
    return senderName.hashCode ^
        senderid.hashCode ^
        message.hashCode ^
        time.hashCode;
  }
}
