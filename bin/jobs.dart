abstract class IJob {
  String get name;
  String get extra;
  double get progress;
}

class ConstJob extends IJob {
  @override
  String name;
  @override
  String extra;
  @override
  double get progress => 0.5;

  ConstJob(this.name, this.extra);
}

final _jobs = <String, List<IJob>>{
  "pingpingu": [
    ConstJob("id.mp4", "5s • 56MB/s"),
    ConstJob("fedora.iso", "2m34s • 1.8MB/s"),
  ],
  "backupper": [
    ConstJob("~sink", "70/100 files"),
  ]
};

Iterable<MapEntry<String, List<IJob>>> jobs() => _jobs.entries;

void addJob(String type, IJob job) {
  if (_jobs.containsKey(type)) _jobs[type]!.add(job);
  _jobs[type] = [job];
}

void removeJob(String type, IJob job) {
  _jobs[type]?.remove(job);
}
