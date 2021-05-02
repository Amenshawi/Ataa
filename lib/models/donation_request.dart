import 'package:Ataa/models/app_user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationRequest {
  final String type;
  final AppUser user;
  final bool anonymous;
  final LatLng location;
  final String importance;
  DateTime timeStamp;
  String status;
  final String rid; // request  id
  DonationRequest(
      {this.type,
      this.user,
      this.anonymous,
      this.location,
      this.timeStamp,
      this.status,
      this.importance,
      this.rid}) {
    if (this.timeStamp == null) this.timeStamp = DateTime.now();
    if (this.status == null) this.status = 'active';
  }
}
