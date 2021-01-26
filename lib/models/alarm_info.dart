class AlarmInfo {
  int id;
  int minute;
  int hour;
  String days;
  String label;
  String period;
  int status;

  AlarmInfo(
      {this.id,
      this.hour,
      this.minute,
      this.status,
      this.label,
      this.days,
      this.period});

  factory AlarmInfo.fromJson(Map<String, dynamic> json) {
    return AlarmInfo(
      id: json["id"],
      label: json["label"],
      hour: json["hour"],
      minute: json["minute"],
      period: json["period"],
      status: json["status"],
      days: json["days"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "hour": hour,
        "minute": minute,
        "period": period,
        "status": status,
        "days": days,
      };
}
