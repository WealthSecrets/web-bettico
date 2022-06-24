enum OTPReceiverType { phoneNumber, email }

extension OTPReceiverTypeX on OTPReceiverType {
  String get name {
    switch (this) {
      case OTPReceiverType.phoneNumber:
        return 'Phone';
      case OTPReceiverType.email:
        return 'Email';
    }
  }
}
