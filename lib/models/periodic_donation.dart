class PeriodicDonation {
  final String type;
  final DateTime date;
  final String pdid; //periodic donation id
  final String status;
  PeriodicDonation(this.type, this.date, this.status, {this.pdid = ''});
}
