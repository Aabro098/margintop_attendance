enum WorkLocation {
  office,
  home,
  absent;

  String get statusValue {
    switch (this) {
      case WorkLocation.office:
        return 'present';
      case WorkLocation.home:
        return 'remote';
      case WorkLocation.absent:
        return 'absent';
    }
  }

  String get label {
    switch (this) {
      case WorkLocation.office:
        return 'Office';
      case WorkLocation.home:
        return 'Home';
      case WorkLocation.absent:
        return 'Absent';
    }
  }
}
