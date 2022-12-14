import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/models/livestream.dart';
import 'package:twitch_clone/models/users.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/resources/storage_methods.dart';
import 'package:twitch_clone/utils/utils.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    String channelId = '';
    try {
      if (title.isNotEmpty && image != null) {
        if (!(await _firestore
                .collection('livestream')
                .doc(user.user.uid)
                .get())
            .exists) {
          String thumbnailUrl = await _storageMethods.uploadImageToStorage(
            'livestream-thumbnails',
            image,
            user.user.uid,
          );

          //useridusername is channelid
          channelId = '${user.user.uid}${user.user.username}';
          LiveStream liveStream = LiveStream(
              title: title,
              image: thumbnailUrl,
              uid: user.user.uid,
              username: user.user.username,
              viewers: 0,
              channelId: channelId,
              startedAt: DateTime.now());

          _firestore
              .collection('livestream')
              .doc(channelId)
              .set(liveStream.toMap());
        } else {
          showSnackBar(context, 'Two livestream are not possible at same time');
        }
      } else {
        showSnackBar(context, 'Please enter all the fields');
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return channelId;
  }
}
