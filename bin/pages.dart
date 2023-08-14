final stylesheet = """

""";

String _template(String page, [String head = ""]) => """
  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="stylesheet" href="style.css" />
      <title>Michirutils</title>
    </head>

    <body>
      $page
    </body>
  </html>
""";

final mainPage = _template("""
  <h1>Michirutils</h1>
  <iframe src="status" />
""");

var _debugCount = 0;

String statusPage() => _template("""
    ${_debugCount++}
  """,
  '<meta http-equiv="refresh" content="10"'
);