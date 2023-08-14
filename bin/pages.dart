import 'jobs.dart';

final stylesheet = """
body {
  display: flex;
  flex-direction: column;
  text-align: center;
  margin: auto;
  padding: 1rem;
  max-width: 40rem;
  background: #333;
  color: #EEE;
  font-family: sans-serif;
}

a { color: #296abb }

a:visited { color: #a555e8 }

iframe { border: none }

.job-group {
  text-align: left;
  padding-left: 3rem;
}

.job-group h2 { margin: .5rem; margin-left: -3rem; }

.job-data {
  display: flex;
  justify-content: space-between;
  color: #BBB;
}

.job-data p { margin: 0 }

.job-progress {
  background: #555;
  margin-bottom: .4rem;
  margin-top: .2rem;
}

.job-progress div {
  background: white;
  height: 1px;
  width: var(--p);
}
""";

String _template(String page, [String head = ""]) => """
  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="stylesheet" href="style.css" />
      <title>Michirutils</title>
      $head
    </head>

    <body>
      $page
    </body>
  </html>
""";

final mainPage = _template("""
  <h1>Michirutils</h1>
  <iframe src="status" id="statusframe" />
""");

String statusPage() => _template(
    // ignore: prefer_interpolation_to_compose_strings
    jobs().map((group) => """

    <div class="job-group">
      <h2>${group.key}</h2>
    ${group.value.map((job) => """
        <div class="job-data">
          <p>${job.name}</p>
          <p>${job.extra}</p>
        </div>
        <div class="job-progress" style="--p: ${job.progress * 100}%">
          <div></div>
        </div>
      """).join()}
    </div>

  """).join() +
        // https://stackoverflow.com/a/247160
        "<script>parent.document.getElementById('statusframe').style.height = document.body.offsetHeight + 'px'</script>",
    '<meta http-equiv="refresh" content="3" />');

String pingpinguPage() =>
    _template(""" <h1>Michirutils Pingpingu</h1> <p>//TODO</p> """);
