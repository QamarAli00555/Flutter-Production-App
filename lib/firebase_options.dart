import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? const FirebaseOptions(
        apiKey: Your_API_Key,
        appId: Your_APP_Id,
        messagingSenderId: Your_Sender_Id,
        projectId: Your_Project_Id,)
    : const FirebaseOptions(
        apiKey: Your_API_Key,
        appId:  Your_APP_Id,
        messagingSenderId:  Your_Sender_Id,
        projectId: Your_Project_Id);
