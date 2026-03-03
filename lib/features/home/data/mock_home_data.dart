import '../../../shared/models/event_model.dart';
import '../../../shared/models/song_model.dart';
import '../../../shared/models/verse_model.dart';

/// Mock data for the Home feature
abstract final class MockHomeData {
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
