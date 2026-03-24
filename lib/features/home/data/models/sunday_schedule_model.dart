import '../../domain/entities/sunday_schedule.dart';

/// Sunday Schedule Model for JSON serialization
class SundayScheduleModel extends SundaySchedule {
  const SundayScheduleModel({
    required super.id,
    required super.date,
    required super.sermon,
    required super.branches,
    required super.gathering,
    required super.team,
    required super.sundaySchool,
  });

  factory SundayScheduleModel.fromJson(Map<String, dynamic> json) {
    return SundayScheduleModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      date: DateTime.parse(json['date'] as String),
      sermon: SermonInfoModel.fromJson(json['sermon'] as Map<String, dynamic>),
      branches: (json['branches'] as List<dynamic>?)
              ?.map((e) => BranchInfoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      gathering: GatheringInfoModel.fromJson(json['gathering'] as Map<String, dynamic>),
      team: TeamInfoModel.fromJson(json['team'] as Map<String, dynamic>),
      sundaySchool: SundaySchoolInfoModel.fromJson(json['sundaySchool'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'sermon': (sermon as SermonInfoModel).toJson(),
      'branches': branches.map((e) => (e as BranchInfoModel).toJson()).toList(),
      'gathering': (gathering as GatheringInfoModel).toJson(),
      'team': (team as TeamInfoModel).toJson(),
      'sundaySchool': (sundaySchool as SundaySchoolInfoModel).toJson(),
    };
  }
}

class SermonInfoModel extends SermonInfo {
  const SermonInfoModel({
    required super.speaker,
    required super.title,
    super.topic,
  });

  factory SermonInfoModel.fromJson(Map<String, dynamic> json) {
    return SermonInfoModel(
      speaker: json['speaker'] as String? ?? '',
      title: json['title'] as String? ?? '',
      topic: json['topic'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speaker': speaker,
      'title': title,
      'topic': topic,
    };
  }
}

class BranchInfoModel extends BranchInfo {
  const BranchInfoModel({
    required super.name,
    required super.speaker,
  });

  factory BranchInfoModel.fromJson(Map<String, dynamic> json) {
    return BranchInfoModel(
      name: json['name'] as String? ?? '',
      speaker: json['speaker'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'speaker': speaker,
    };
  }
}

class GatheringInfoModel extends GatheringInfo {
  const GatheringInfoModel({
    required super.type,
    required super.name,
  });

  factory GatheringInfoModel.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String? ?? 'section';
    return GatheringInfoModel(
      type: typeStr == 'regional' ? GatheringType.regional : GatheringType.section,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type == GatheringType.regional ? 'regional' : 'section',
      'name': name,
    };
  }
}

class TeamInfoModel extends TeamInfo {
  const TeamInfoModel({
    required super.name,
    required super.leader,
  });

  factory TeamInfoModel.fromJson(Map<String, dynamic> json) {
    return TeamInfoModel(
      name: json['name'] as String? ?? '',
      leader: json['leader'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'leader': leader,
    };
  }
}

class SundaySchoolInfoModel extends SundaySchoolInfo {
  const SundaySchoolInfoModel({
    required super.preparation,
    required super.junior,
    required super.senior,
  });

  factory SundaySchoolInfoModel.fromJson(Map<String, dynamic> json) {
    return SundaySchoolInfoModel(
      preparation: TeacherInfoModel.fromJson(json['preparation'] as Map<String, dynamic>),
      junior: TeacherInfoModel.fromJson(json['junior'] as Map<String, dynamic>),
      senior: TeacherInfoModel.fromJson(json['senior'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preparation': (preparation as TeacherInfoModel).toJson(),
      'junior': (junior as TeacherInfoModel).toJson(),
      'senior': (senior as TeacherInfoModel).toJson(),
    };
  }
}

class TeacherInfoModel extends TeacherInfo {
  const TeacherInfoModel({
    required super.name,
    required super.role,
  });

  factory TeacherInfoModel.fromJson(Map<String, dynamic> json) {
    return TeacherInfoModel(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? 'а',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
    };
  }
}

/// Response model for weekly sunday schedules
class SundayScheduleWeeklyResponse {
  final SundayScheduleModel? current;
  final SundayScheduleModel? next;

  const SundayScheduleWeeklyResponse({
    this.current,
    this.next,
  });

  factory SundayScheduleWeeklyResponse.fromJson(Map<String, dynamic> json) {
    return SundayScheduleWeeklyResponse(
      current: json['current'] != null
          ? SundayScheduleModel.fromJson(json['current'] as Map<String, dynamic>)
          : null,
      next: json['next'] != null
          ? SundayScheduleModel.fromJson(json['next'] as Map<String, dynamic>)
          : null,
    );
  }
}
