enum PhotoResolution { LOW, NORMAL, HIGH }

extension PhotoResolutionExtension on PhotoResolution {
  int get width {
    switch (this) {
      case PhotoResolution.LOW:
        return 100;
      case PhotoResolution.NORMAL:
        return 480;
      case PhotoResolution.HIGH:
        return 1024;
      default:
        return 100;
    }
  }

  int get height {
    switch (this) {
      case PhotoResolution.LOW:
        return 100;
      case PhotoResolution.NORMAL:
        return 480;
      case PhotoResolution.HIGH:
        return 1024;
      default:
        return 100;
    }
  }
}
