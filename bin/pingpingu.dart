import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'config.dart';
import 'jobs.dart';

class PingpinguJob extends IJob {
  @override
  String extra;
  @override
  String name;
  @override
  double progress = 0;

  PingpinguJob(this.name, this.extra);
}

bool checkPassword(String? pass) =>
    pass != null &&
    sha512.convert(utf8.encode(pass)).toString() == PINGPINGU_SHA512;
