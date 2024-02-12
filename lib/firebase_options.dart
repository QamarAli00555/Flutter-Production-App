import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? const FirebaseOptions(
        apiKey: 'AIzaSyD53WLIENaLqF0denKHhn3rsrPwtCzNMrI',
        appId: '1:1004479452704:android:66ff2c31b773b914608e45',
        messagingSenderId: '1004479452704',
        projectId: 'productionapp-1b418')
    : const FirebaseOptions(
        apiKey: 'AIzaSyD9go2lf8RhmvhIh588WGdVxZ2DidQU1WU',
        appId: '1:1004479452704:ios:9fbf637b05b25dde608e45',
        messagingSenderId: '1004479452704',
        projectId: 'productionapp-1b418');
