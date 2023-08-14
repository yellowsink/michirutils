import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'pages.dart' as pages;
import 'pingpingu.dart' as pingpingu;

Response resp(String text, [String mime = "text/html"]) =>
    Response.ok(text, headers: {"Content-Type": mime});

Response unauthed() =>
    Response.unauthorized("401 Unauthorized. You're logged out.",
        headers: {"Set-Cookie": "pass=; Max-Age=-1"});

final router = Router()
  // static
  ..get('/', (_) => resp(pages.mainPage))
  ..get('/style.css', (_) => resp(pages.stylesheet, "text/css"))
  // dynamic
  ..get('/status', (_) => resp(pages.statusPage()))
  ..get('/pingpingu', (Request req) {
    // lord help us if youre not using HTTPS!
    final givenPass = req.params["pass"];

    return pingpingu.checkPassword(givenPass)
        ? Response.ok(pages.pingpinguPage(), headers: {
            "Set-Cookie":
                "pass=$givenPass; Secure; Max-Age=120; Path=/pingpingu",
            "Content-Type": "text/html"
          })
        : unauthed();
  })
  ..post('/pingpingu/finish', (Request req) {
    final pass = RegExp(r'pass=(.+?);')
        .firstMatch(req.headers["cookie"] ?? "")
        ?.group(1);
    if (pass == null || !pingpingu.checkPassword(pass)) {
      return unauthed();
    }

    final file = req.params["f"];
    if (file == null) {
      return Response.badRequest(
          body: "400 Bad Request. You're logged out.",
          headers: {"Set-Cookie": "pass=; Max-Age=-1"});
    }

    // TODO: DO SHIT!

    return Response.seeOther("/", headers: {"Set-Cookie": "pass=; Max-Age=-1"});
  });

void main(List<String> args) async {
  final server = await serve(router, InternetAddress.anyIPv4, 8080);

  print('Server listening on port ${server.port}');
}
