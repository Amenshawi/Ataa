import 'dart:io';
import 'dart:math';
import 'package:Ataa/models/Periodic_donation.dart';
import 'package:Ataa/models/donation.dart';
import 'package:Ataa/models/donation_request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Ataa/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class Database {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static String _uid;
  Database();

  static Future addUser(String uid, String email, String fname, String lname,
      DateTime bday) async {
    CollectionReference users = _firestore.collection('users');

    users.add({
      'uid': uid,
      'email': email,
      'first_name': fname,
      'last_name': lname,
      'birthdate': bday,
      'type': 'Donor',
      'private': false
    }).then((value) {
      print("User Added");
      return true;
    }).catchError((error) => print("Failed to add user: $error"));
  }

  static Future fetchUserData(User fUser) async {
    _uid = fUser.uid;
    return await _firestore
        .collection('users')
        .where('uid', isEqualTo: fUser.uid)
        .get()
        .then((value) {
      final user = AppUser(
          uid: fUser.uid,
          email: value.docs.first.data()['email'],
          fname: value.docs.first.data()['first_name'],
          lname: value.docs.first.data()['last_name'],
          shirtSize: value.docs.first.data()['shirtSize'],
          pantSize: value.docs.first.data()['pantsSize'],
          shoeSize: value.docs.first.data()['shoeSize'],
          addressLine: value.docs.first.data()['adreeLine'],
          location: value.docs.first.data()['geoPoint'],
          privacy: value.docs.first.data()['private']);
      print('user Data fetched successfully !');
      return user;
    }).catchError((error) => print("Failed to fetch user data: $error"));
  }

  static AppUser _fetchDataFromSnapshot(QuerySnapshot snapshot) {
    return AppUser(
        uid: snapshot.docs.first.data()['uid'],
        email: snapshot.docs.first.data()['email'],
        fname: snapshot.docs.first.data()['first_name'],
        lname: snapshot.docs.first.data()['last_name'],
        shirtSize: snapshot.docs.first.data()['shirtSize'],
        pantSize: snapshot.docs.first.data()['pantsSize'],
        shoeSize: snapshot.docs.first.data()['shoeSize'],
        addressLine: snapshot.docs.first.data()['adreeLine'],
        location: snapshot.docs.first.data()['geoPoint'],
        privacy: snapshot.docs.first.data()['private']);
  }

  static Stream<AppUser> get user {
    return _firestore
        .collection('users')
        .where('uid', isEqualTo: _uid)
        .snapshots()
        .map((_fetchDataFromSnapshot));
  }

  static Future searchForCharity(String name) async {
    final result = await _firestore
        .collection('charities')
        .orderBy('name')
        .startAt([name])
        .endAt([name + '\uf8ff'])
        .get()
        .then((snapshot) {
          for (var i = 0; i < snapshot.docs.length; i++) {
            print(snapshot.docs[i].data()['name']);
          }
          return snapshot.docs;
        })
        .catchError((error) => print("Failed to search for charities: $error"));
    return result;
  }

  static Future changePrivacy(AppUser user, bool changTo) async {
    await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) async {
      await _firestore
          .collection('users')
          .doc(value.docs[0].id)
          .update({'private': changTo});
      return true;
    }).catchError((error) => {
              //do something when an error happens
            });
  }

  static Future<bool> getPrivacy(AppUser user) async {
    print('getting privacy');
    final doc = await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) {
      return value.docs[0].data();
    });
    print(doc['private']);
    if (doc['private'] == true) {
      print('returning true');
      return true;
    } else {
      print('returning false');
      return false;
    }
  }

  static Future updateClothesSizes(
      String shirtSize, String pantsSize, int shoeSize, AppUser user) async {
    print('hi');
    return await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) async {
      await _firestore.collection('users').doc(value.docs[0].id).update({
        'shirtSize': shirtSize,
        'pantsSize': pantsSize,
        'shoeSize': shoeSize
      });
      return true;
    }).catchError((error) => {
              print(error.toString)
              //do something when an error happens
            });
  }

  static Future addDonation(Donation donation) async {
    String status =
        donation.timeStamp.add(Duration(seconds: 1)).isAfter(donation.notifyAt)
            ? 'active'
            : 'scheduled';
    GeoPoint geopoint =
        GeoPoint(donation.location.latitude, donation.location.longitude);
    final url = await uploadImage(donation.image);
    final ref = await _firestore
        .collection('users')
        .where('uid', isEqualTo: donation.user.uid)
        .get()
        .then((value) {
      return value.docs[0].reference;
    });
    await _firestore.collection('donations').add({
      'type': donation.type,
      'user': ref,
      'image': url,
      'desc': donation.desc,
      'anonymous': donation.anonymous,
      'location': geopoint,
      'notifyAt': donation.notifyAt,
      'timeStamp': donation.timeStamp,
      'status': status
    }).then((value) {
      print('donation added');
      return;
    }).catchError((error) {
      print('couldn\'t add donation.\nError: ' + error.toString());
      return error;
    });
  }

  static Future<String> uploadImage(File _image) async {
    final rn = new Random().nextInt(99999);

    String url;
    Reference ref = _firebaseStorage
        .ref()
        .child('donations/D' + DateTime.now().toString() + rn.toString());
    UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      print('File Uploaded');
    }).catchError((error) {
      print('couldn\'t upload image');
      print(error.toString());
    });

    return url;
  }

  static Future<void> addLocation(
      String addressLine, LatLng location, AppUser user) async {
    GeoPoint geopoint = GeoPoint(location.latitude, location.longitude);
    return await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) async {
      await _firestore
          .collection('users')
          .doc(value.docs[0].id)
          .update({'geoPoint': geopoint, 'addressLine': addressLine});
      return true;
    }).catchError((error) => {
              print(error.toString)
              //do something when an error happens
            });
  }

  static Future<void> updateEmail(String email, AppUser user) async {
    return await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) async {
      await _firestore
          .collection('users')
          .doc(value.docs[0].id)
          .update({'email': email});
    });
  }

  static Future<List<PeriodicDonation>> fetchPeriodcDonations(
      AppUser user) async {
    List<PeriodicDonation> donations = [];
    await _firestore
        .collection('periodic_donations')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.data()['status'] != 'terminated')
          donations.add(new PeriodicDonation(
              doc.data()['type'],
              DateTime.parse(doc.data()['date'].toDate().toString()),
              doc.data()['status'],
              pdid: doc.id));
      });
    });
    return donations;
  }

  static void pausePeriodicDonation(String pdid) async {
    await _firestore
        .collection('periodic_donations')
        .doc(pdid)
        .update({'status': 'paused'});
  }

  static void terminatePeriodicDonation(String pdid) async {
    await _firestore
        .collection('periodic_donations')
        .doc(pdid)
        .update({'status': 'terminated'});
  }

  static void resumePeriodicDonation(String pdid) async {
    await _firestore
        .collection('periodic_donations')
        .doc(pdid)
        .update({'status': 'active'});
  }

  static void addWeekly(
      AppUser user, String type, DateTime startDate, List<bool> days) async {
    String stringDays = _getDays(days);
    await _firestore.collection('periodic_donations').add({
      'uid': user.uid,
      'status': 'active',
      'type': type,
      'date': startDate,
      'frequency': 'Weekly',
      'days': stringDays
    });

    print('donation added');
  }

  static String _getDays(List<bool> days) {
    String stringDays = '';
    if (days[0]) stringDays = stringDays + 'Sunday,';
    if (days[1]) stringDays = stringDays + 'Monday,';
    if (days[2]) stringDays = stringDays + 'Tuesday,';
    if (days[3]) stringDays = stringDays + 'Wednesday,';
    if (days[4]) stringDays = stringDays + 'Thursday,';
    if (days[5]) stringDays = stringDays + 'Friday,';
    if (days[6]) stringDays = stringDays + 'Saturday,';

    return stringDays;
  }

  static void addMonthly(
      AppUser user, String type, DateTime startDate, List<int> days) async {
    final String stringDays = _getMonthDays(days);
    await _firestore.collection('periodic_donations').add({
      'uid': user.uid,
      'status': 'active',
      'type': type,
      'date': startDate,
      'frequency': 'Monthly',
      'days': stringDays
    });

    print('donation added');
  }

  static String _getMonthDays(List<int> days) {
    String stringDays = '';
    days.forEach((day) {
      stringDays = stringDays + day.toString() + ',';
    });

    return stringDays;
  }

  static Future<List<Donation>> fetchDonations(AppUser user) async {
    final ref = await _firestore
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) {
      return value.docs[0].reference;
    });
    List<Donation> donations = [];
    await _firestore
        .collection('donations')
        .where('user', isEqualTo: ref)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        donations.add(new Donation(
            type: doc.data()['type'],
            timeStamp:
                DateTime.parse(doc.data()['timeStamp'].toDate().toString()),
            status: doc.data()['status'],
            did: doc.id,
            imageURL: doc.data()['image']));
      });
    });
    return donations;
  }

  static void cancelDonation(String ddid) async {
    await _firestore
        .collection('donations')
        .doc(ddid)
        .update({'status': 'canceled'});
  }

  static void addDonationRequest(DonationRequest request) async {
    GeoPoint geopoint;
    if (request.location != null)
      geopoint =
          GeoPoint(request.location.latitude, request.location.longitude);

    await _firestore.collection('donation_requests').add({
      'type': request.type,
      'uid': request.user.uid,
      'anonymous': request.anonymous,
      'location': geopoint,
      'timeStamp': request.timeStamp,
      'status': request.status
    }).then((value) {
      print('donation request added');
      return;
    }).catchError((error) {
      print('couldn\'t add donation request.\nError: ' + error.toString());
      return error;
    });
  }

  static Future<List<DonationRequest>> fetchDonationRequests(
      AppUser user) async {
    List<DonationRequest> requests = [];
    await _firestore
        .collection('donation_requests')
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.data()['status'] == 'active')
          requests.add(new DonationRequest(
              type: doc.data()['type'],
              timeStamp:
                  DateTime.parse(doc.data()['timeStamp'].toDate().toString()),
              status: doc.data()['status'],
              rid: doc.id));
      });
    });
    return requests;
  }

  static void cancelDonationRequest(String rid) async {
    await _firestore
        .collection('donation_requests')
        .doc(rid)
        .update({'status': 'canceled'});
  }

  static Future<List<Donation>> fetchActiveDonations() async {
    List<Donation> donations = [];
    await _firestore
        .collection('donations')
        .where('status', isEqualTo: 'active')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        donations.add(Donation(
            type: doc.data()['type'],
            timeStamp:
                DateTime.parse(doc.data()['timeStamp'].toDate().toString()),
            status: doc.data()['status'],
            did: doc.id));
      });
    });
    return donations;
  }

  static Future<List<DonationRequest>> fetchActiveRequests() async {
    List<DonationRequest> requests = [];
    await _firestore
        .collection('donation_requests')
        .where('status', isEqualTo: 'active')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        requests.add(DonationRequest(
            type: doc.data()['type'],
            timeStamp:
                DateTime.parse(doc.data()['timeStamp'].toDate().toString()),
            status: doc.data()['status'],
            rid: doc.id));
      });
    });
    return requests;
  }
}
