import 'package:equatable/equatable.dart';

/// Ням гаргийн үйлчлэлийн хуваарь
class SundaySchedule extends Equatable {
  final String id;
  final DateTime date;
  final SermonInfo sermon;
  final List<BranchInfo> branches;
  final GatheringInfo gathering;
  final TeamInfo team;
  final SundaySchoolInfo sundaySchool;

  const SundaySchedule({
    required this.id,
    required this.date,
    required this.sermon,
    required this.branches,
    required this.gathering,
    required this.team,
    required this.sundaySchool,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        sermon,
        branches,
        gathering,
        team,
        sundaySchool,
      ];
}

/// Номлолын мэдээлэл
class SermonInfo extends Equatable {
  final String speaker;
  final String title;
  final String? topic;

  const SermonInfo({
    required this.speaker,
    required this.title,
    this.topic,
  });

  @override
  List<Object?> get props => [speaker, title, topic];
}

/// Салбар чуулганы мэдээлэл
class BranchInfo extends Equatable {
  final String name;
  final String speaker;

  const BranchInfo({
    required this.name,
    required this.speaker,
  });

  @override
  List<Object?> get props => [name, speaker];
}

/// Цуглааны мэдээлэл
class GatheringInfo extends Equatable {
  final GatheringType type;
  final String name;

  const GatheringInfo({
    required this.type,
    required this.name,
  });

  @override
  List<Object?> get props => [type, name];
}

/// Цуглааны төрөл
enum GatheringType {
  section, // Хэсгийн нөхөрлөл
  regional, // Бүсийн нөхөрлөл
}

/// Багийн мэдээлэл
class TeamInfo extends Equatable {
  final String name;
  final String leader;

  const TeamInfo({
    required this.name,
    required this.leader,
  });

  @override
  List<Object?> get props => [name, leader];
}

/// Чуулганы сургуулийн мэдээлэл
class SundaySchoolInfo extends Equatable {
  final TeacherInfo preparation;
  final TeacherInfo junior;
  final TeacherInfo senior;

  const SundaySchoolInfo({
    required this.preparation,
    required this.junior,
    required this.senior,
  });

  @override
  List<Object?> get props => [preparation, junior, senior];
}

/// Багшийн мэдээлэл
class TeacherInfo extends Equatable {
  final String name;
  final String role;

  const TeacherInfo({
    required this.name,
    required this.role,
  });

  String get displayName => '$name $role';

  @override
  List<Object?> get props => [name, role];
}
