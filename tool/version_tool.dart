import 'package:pub_semver/pub_semver.dart';

enum VersionNumber {
  MAJOR,
  MINOR,
  PATCH,
}

class VersionTool {
  Version version;
  VersionTool(this.version);
  VersionTool.fromText(String text) : version = Version.parse(text);

  Version get nextMajor => _addBuildNumber(VersionNumber.MAJOR);
  Version get nextMinor => _addBuildNumber(VersionNumber.MINOR);
  Version get nextPatch => _addBuildNumber(VersionNumber.PATCH);

  Version nextMajorTag(String tag) => _addBuildNumber(
        VersionNumber.MAJOR,
        tag: tag,
      );
  Version nextMinorTag(String tag) => _addBuildNumber(
        VersionNumber.MINOR,
        tag: tag,
      );
  Version nextPatchTag(String tag) => _addBuildNumber(
        VersionNumber.PATCH,
        tag: tag,
      );

  Version _addBuildNumber(VersionNumber type, {String? tag}) {
    switch (type) {
      case VersionNumber.MAJOR:
        return Version(
          version.major,
          version.minor,
          version.patch + 1,
          pre: tag,
          build: '${(version.build.first as int) + 1}',
        );
      case VersionNumber.MINOR:
        return Version(
          version.major,
          version.minor + 1,
          0,
          pre: tag,
          build: '${(version.build.first as int) + 1}',
        );
      case VersionNumber.PATCH:
        return Version(
          version.major + 1,
          0,
          0,
          pre: tag,
          build: '${(version.build.first as int) + 1}',
        );
    }
  }
}
