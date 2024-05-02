import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../firebase_options.dart';

import 'entity/userdata.dart';

class Appointment {

  Appointment._privateConstructor();


  static final Appointment _instance = Appointment._privateConstructor();


  static Appointment get instance => _instance;


  Future <void> bookAppointment(AppointmentData data) async {

    var parentDocRef = FirebaseFirestore.instance.collection("users").doc(data.doctoruuid);

    CollectionReference subCollectionRef = parentDocRef.collection('appointment');
    var newDocRef = await subCollectionRef.add({
      'userId': data.userId,
      'time': data.time,
      'date': data.date,
      'status': data.status,
    });

    String appointmentId = newDocRef.id;
    await newDocRef.update({'appointmentId': appointmentId});
  }

  Future <void> saveToUserNotifications(AppointmentData data, String status) async {

    var parentDocRef =  FirebaseFirestore.instance.collection("users").doc(data.userId);

    CollectionReference subCollectionRef = parentDocRef.collection('notifications');
    var docRef = subCollectionRef.doc();
    subCollectionRef.add({
      'time': data.time,
      'date': data.date,
      'status': status,
      'appointmentId': docRef.id
    });
  }

  Future<List<NotificationData>> getTOUserNotification(AppointmentData data) async {
    List<NotificationData> notificationDataList = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference userCollectionRef = firestore.collection('users');

      QuerySnapshot subcollectionSnapshot = await userCollectionRef
          .doc(data.userId)
          .collection('notifications')
          .get();

      // Get doctor data using doctoruuid

      var doctorCollectionRef = await firestore.collection('users').doc(data.doctoruuid).get();
      var doctorData = doctorCollectionRef.data();
      var doctorImage = doctorData?['image'];
      var doctorName = doctorData?['name'];

      // class named NotificationData contains ( date, time, status, doctorName, doctorImage )
      subcollectionSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        var status = data['status'];
        var date = data['time'];
        var time = data['status'];

        NotificationData notificationData = NotificationData(date: date,
            time: time, status: status,
            doctorName: doctorName, doctorImage: doctorImage);

        notificationDataList.add(notificationData);
      });
    } catch (e) {
      print('Error fetching subcollection data: $e');
    }
    return notificationDataList;
  }

  Future<List<AppointmentData>> getBookAppointmentData(AppointmentData data) async {
    List<AppointmentData> appointmentDataList = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference doctorLoginCollectionRef = firestore.collection('users');

      QuerySnapshot subcollectionSnapshot = await doctorLoginCollectionRef
          .doc(data.userId)
          .collection('appointment')
          .get();

      subcollectionSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        AppointmentData appointmentData = AppointmentData(
            userId: data['userId'],
            date: data['date'],
            time: data['time'],
            status: data['status'],
            appointmentId: data['appointmentId']
        );

        appointmentDataList.add(appointmentData);
      });
    } catch (e) {
      print('Error fetching subcollection data: $e');
    }
    return appointmentDataList;
  }




  Future<void> sendNotification(String userId) async {
    try {
      var userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDataSnapshot.exists) {
        var userData = userDataSnapshot.data();
        var token = userData?['token'];

        var payload = {
          'notification': {
            'title': 'Notification Title',
            'body': 'Notification Body',
          },
          'data': {

            'click_action': 'NOTIFICATION_CLICK',
          },
          'token': token,
        };

        var jsonPayload = jsonEncode(payload);

        var response = await http.post(
          Uri.parse('YOUR_API_ENDPOINT_URL'),
          headers: {'Content-Type': 'application/json'},
          body: jsonPayload,
        );

        if (response.statusCode == 200) {
          print('Notification sent successfully!');
        } else {
          print('Failed to send notification. Status code: ${response.statusCode}');
        }
      } else {
        print('User document not found in Firestore.');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> updateAppointmentStatus(String appointmentId, String status) async {
    var doctorId = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .collection('appointment')
          .doc(appointmentId)
          .update({
        'status': status
      });
    } on PlatformException catch (e) {
      if (e.code == 'not-found') {
        print('Document not found.');
      } else {
        print('Error sending notification: $e');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }




  Future<String?> getToken() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    String? token = await FirebaseMessaging.instance.getToken();

    if (kDebugMode) {
      print("Token = $token");
    }
    return token;
  }
}

