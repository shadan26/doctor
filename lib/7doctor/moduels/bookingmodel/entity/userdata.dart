class AppointmentData {
  final String ?doctoruuid;
  final String ?userId;
  final String ?date;
  final String? time;
  late final String ?status;
  final String ?appointmentId;


  AppointmentData({
    this.appointmentId,
    this.status,
    this.doctoruuid,
    this.userId,
    this.date,
    this.time,

  });
}


class NotificationData {
  final String ?userId;
  final String ?date;
  final String ?time;
  final String ?doctorName;
  final String? doctorImage;
  late final String ?status;

  NotificationData({
    this.userId,
    this.date,
    this.time,
    this.doctorName,
    this.doctorImage,
    this.status,
  });
}