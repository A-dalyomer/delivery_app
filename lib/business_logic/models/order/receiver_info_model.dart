/// This model is used as a DTO to store the receiver info in the [ReceiverInfo]
class ReceiverInfo {
  ReceiverInfo({
    required this.name,
    required this.phoneNumber,
    required this.note,
  });

  late final String name;
  late final String phoneNumber;
  late final String note;
}
