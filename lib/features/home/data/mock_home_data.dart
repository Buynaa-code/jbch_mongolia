import '../../../shared/models/event_model.dart';
import '../../../shared/models/song_model.dart';
import '../../../shared/models/verse_model.dart';
import '../domain/entities/announcement.dart';
import '../domain/entities/sunday_schedule.dart';
import 'models/announcement_model.dart';

/// Mock data for the Home feature
abstract final class MockHomeData {
  /// Active announcements for carousel
  static List<AnnouncementModel> get announcements => [
        AnnouncementModel(
          id: 'ann1',
          title: 'Шинэ жилийн тусгай цуглаан',
          description:
              'Бид хамтдаа шинэ жилийн баярыг тэмдэглэх болно. Бүх гэр бүлүүдийг урьж байна!',
          priority: AnnouncementPriority.important,
          actionLabel: 'Дэлгэрэнгүй',
          actionUrl: '/events/new-year',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        ),
        AnnouncementModel(
          id: 'ann2',
          title: 'Библийн сургалт эхэлж байна',
          description:
              'Шинэ гэрээний номуудыг судлах сургалт 2 дахь сарын 1-нээс эхэлнэ.',
          priority: AnnouncementPriority.normal,
          actionLabel: 'Бүртгүүлэх',
          actionUrl: '/events/bible-study',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        AnnouncementModel(
          id: 'ann3',
          title: 'Яаралтай залбирлын хүсэлт',
          description:
              'Ахан дүүсийн эрүүл мэнд болон гэр бүлийн төлөө залбирч өгнө үү.',
          priority: AnnouncementPriority.urgent,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
      ];

  /// Ням гаргийн үйлчлэлийн хуваарь - Энэ долоо хоног
  static SundaySchedule get currentSundaySchedule {
    // Энэ ням гаргийг олох
    final now = DateTime.now();
    final daysUntilSunday = DateTime.sunday - now.weekday;
    final thisSunday = now.add(Duration(days: daysUntilSunday >= 0 ? daysUntilSunday : 7 + daysUntilSunday));

    return SundaySchedule(
      id: '1',
      date: thisSunday,
      sermon: const SermonInfo(
        speaker: 'Жан Жихүн',
        title: 'пастор',
      ),
      branches: const [
        BranchInfo(name: 'УБ Баруун', speaker: 'Лутжаргал пастор'),
        BranchInfo(name: 'Сэлэнгэ', speaker: 'Булган-Эрдэнэ номлогч'),
      ],
      gathering: const GatheringInfo(
        type: GatheringType.section,
        name: 'Хэсгийн нөхөрлөл',
      ),
      team: const TeamInfo(
        name: 'Антиох 6',
        leader: 'Хуан Жинүг пастор',
      ),
      sundaySchool: const SundaySchoolInfo(
        preparation: TeacherInfo(name: 'Хүрэлбаатар', role: 'а'),
        junior: TeacherInfo(name: 'Буянтогтох', role: 'п'),
        senior: TeacherInfo(name: 'Дамдиндорж', role: 'а'),
      ),
    );
  }

  /// Ням гаргийн үйлчлэлийн хуваарь - Дараа долоо хоног
  static SundaySchedule get nextSundaySchedule {
    final now = DateTime.now();
    final daysUntilSunday = DateTime.sunday - now.weekday;
    final nextSunday = now.add(Duration(days: (daysUntilSunday >= 0 ? daysUntilSunday : 7 + daysUntilSunday) + 7));

    return SundaySchedule(
      id: '2',
      date: nextSunday,
      sermon: const SermonInfo(
        speaker: 'Юү Хэүн',
        title: 'пастор',
      ),
      branches: const [
        BranchInfo(name: 'УБ Баруун', speaker: 'Лутжаргал пастор'),
        BranchInfo(name: 'Сэлэнгэ', speaker: 'Булган-Эрдэнэ номлогч'),
      ],
      gathering: const GatheringInfo(
        type: GatheringType.regional,
        name: 'Бүсийн нөхөрлөл',
      ),
      team: const TeamInfo(
        name: 'Антиох 7',
        leader: 'Булган-Эрдэнэ номлогч',
      ),
      sundaySchool: const SundaySchoolInfo(
        preparation: TeacherInfo(name: 'Им Синбинь', role: 'а'),
        junior: TeacherInfo(name: 'Булган-Эрдэнэ', role: 'н'),
        senior: TeacherInfo(name: 'Буянтогтох', role: 'п'),
      ),
    );
  }


  /// Upcoming seminars list for carousel
  static List<EventModel> get seminars => [
        EventModel(
          id: '1',
          title: 'Библийн семинар',
          description:
              'Библийн үндсэн номуудын тухай гүнзгий судалгаа хийх семинар. '
              'Бүх насны хүмүүст зориулагдсан.',
          dateTime: DateTime.now().add(const Duration(days: 3, hours: 10)),
          location: 'Төв сүм, 2-р давхар',
          type: EventType.seminar,
          isUpcoming: true,
        ),
        EventModel(
          id: '2',
          title: 'Шинэ гэрээний судалгаа',
          description:
              'Шинэ гэрээний номуудыг дэлгэрэнгүй судлах семинар. '
              'Итгэгчдэд зориулагдсан.',
          dateTime: DateTime.now().add(const Duration(days: 10, hours: 14)),
          location: 'Сургалтын танхим, 3-р давхар',
          type: EventType.seminar,
          isUpcoming: true,
        ),
        EventModel(
          id: '3',
          title: 'Залбирлын семинар',
          description:
              'Залбирлын үндэс болон практик дадлага хийх тусгай цуглаан. '
              'Бүх нас, шатны итгэгчдэд нээлттэй.',
          dateTime: DateTime.now().add(const Duration(days: 17, hours: 9)),
          location: 'Төв сүм, 1-р давхар',
          type: EventType.seminar,
          isUpcoming: true,
        ),
      ];

  /// Weekly program events
  static List<WeeklyProgramItem> get weeklyProgram => [
        WeeklyProgramItem(
          dayName: 'Ням',
          events: [
            WeeklyEvent(
              time: '10:00',
              title: 'Ням гарагийн мөргөл',
              icon: '🙏',
            ),
            WeeklyEvent(
              time: '14:00',
              title: 'Хүүхдийн хичээл',
              icon: '👶',
            ),
          ],
        ),
        WeeklyProgramItem(
          dayName: 'Даваа',
          events: [
            WeeklyEvent(
              time: '19:00',
              title: 'Залбирлын цуглаан',
              icon: '🕯️',
            ),
          ],
        ),
        WeeklyProgramItem(
          dayName: 'Мягмар',
          events: [
            WeeklyEvent(
              time: '19:00',
              title: 'Библи судлал',
              icon: '📖',
            ),
          ],
        ),
        WeeklyProgramItem(
          dayName: 'Лхагва',
          events: [
            WeeklyEvent(
              time: '19:00',
              title: 'Залуучуудын цуглаан',
              icon: '👥',
            ),
          ],
        ),
        WeeklyProgramItem(
          dayName: 'Пүрэв',
          events: [
            WeeklyEvent(
              time: '10:00',
              title: 'Эмэгтэйчүүдийн нөхөрлөл',
              icon: '💐',
            ),
          ],
        ),
        WeeklyProgramItem(
          dayName: 'Баасан',
          events: [
            WeeklyEvent(
              time: '19:00',
              title: 'Хөгжмийн багийн бэлтгэл',
              icon: '🎵',
            ),
          ],
        ),
        WeeklyProgramItem(
          dayName: 'Бямба',
          events: [
            WeeklyEvent(
              time: '15:00',
              title: 'Нөхөрлөлийн уулзалт',
              icon: '🤝',
            ),
          ],
        ),
      ];

  /// Memory verse of the week
  static VerseModel get memoryVerse => const VerseModel(
        id: 'mv1',
        book: 'Иохан',
        chapter: 3,
        verseStart: 16,
        text:
            'Бурхан ертөнцийг үнэхээр хайрласан тул цорын ганц Хүүгээ өгсөн. '
            'Ингэснээр Хүүд итгэгч хэн ч мөхөхгүй, харин мөнх амьтай болох юм.',
        isMemoryVerse: true,
      );

  /// Quick play song (currently playing or suggested)
  static SongModel get quickPlaySong => const SongModel(
        id: 'qs1',
        title: 'Эзэн миний хоньчин',
        artist: 'Магтаалын баг',
        duration: Duration(minutes: 4, seconds: 32),
        category: SongCategory.praise,
        isFavorite: true,
      );

  /// Recent songs for quick access
  static List<SongModel> get recentSongs => const [
        SongModel(
          id: 'rs1',
          title: 'Алдар Бурханд',
          artist: 'Магтаалын баг',
          duration: Duration(minutes: 3, seconds: 45),
          category: SongCategory.praise,
        ),
        SongModel(
          id: 'rs2',
          title: 'Миний зүрхний дуу',
          artist: 'Залуучуудын баг',
          duration: Duration(minutes: 4, seconds: 12),
          category: SongCategory.contemporary,
        ),
        SongModel(
          id: 'rs3',
          title: 'Бурханы хайр',
          artist: 'Хүүхдийн найрал',
          duration: Duration(minutes: 2, seconds: 58),
          category: SongCategory.children,
        ),
      ];
}

/// Represents a day in the weekly program
class WeeklyProgramItem {
  final String dayName;
  final List<WeeklyEvent> events;

  const WeeklyProgramItem({
    required this.dayName,
    required this.events,
  });
}

/// Represents an event in the weekly program
class WeeklyEvent {
  final String time;
  final String title;
  final String icon;

  const WeeklyEvent({
    required this.time,
    required this.title,
    required this.icon,
  });
}
