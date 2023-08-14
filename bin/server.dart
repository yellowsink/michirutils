import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'pages.dart' as pages;

final router = Router()
  // static stuff
  ..get('/', (_) => Response.ok(pages.mainPage))
  ..get('/style.css', (_) => Response.ok(pages.stylesheet))
  ..get('/status', (_) => Response.ok(pages.statusPage()));

void main(List<String> args) async {
  // For running in containers, respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await serve(router, InternetAddress.anyIPv4, port);

  print('Server listening on port ${server.port}');
}
