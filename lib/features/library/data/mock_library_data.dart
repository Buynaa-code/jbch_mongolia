import '../../../shared/models/sermon_model.dart';
import '../../../shared/models/song_model.dart';
import '../../../shared/models/verse_model.dart';

/// Mock data for the Library feature
abstract final class MockLibraryData {
  /// Sample verses
  static List<VerseModel> get verses => const [
        VerseModel(
          id: 'v1',
          book: 'Иохан',
          chapter: 3,
          verseStart: 16,
          text:
              'Бурхан ертөнцийг үнэхээр хайрласан тул цорын ганц Хүүгээ өгсөн. '
              'Ингэснээр Хүүд итгэгч хэн ч мөхөхгүй, харин мөнх амьтай болох юм.',
          isFavorite: true,
          isMemoryVerse: true,
        ),
        VerseModel(
          id: 'v2',
          book: 'Дуулал',
          chapter: 23,
          verseStart: 1,
          verseEnd: 3,
          text:
              'ЭЗЭН бол миний хоньчин. Би дутагдахгүй. '
              'Тэр намайг ногоон бэлчээрт хэвтүүлж, тайван усны хажууд хөтөлнө. '
              'Тэр миний сэтгэлийг сэргээж, Өөрийнхөө нэрийн төлөө зөв замаар намайг удирдана.',
          isFavorite: true,
        ),
        VerseModel(
          id: 'v3',
          book: 'Филиппой',
          chapter: 4,
          verseStart: 13,
          text: 'Намайг хүчирхэгжүүлдэг Түүгээр би бүх юмыг хийж чадна.',
        ),
        VerseModel(
          id: 'v4',
          book: 'Ром',
          chapter: 8,
          verseStart: 28,
          text:
              'Бурханыг хайрладаг хүмүүст, Түүний зорилгоор дуудагдсан хүмүүст '
              'бүх юм хамтдаа сайн үйлд нь ажилладаг гэдгийг бид мэднэ.',
        ),
        VerseModel(
          id: 'v5',
          book: 'Есүс',
          chapter: 41,
          verseStart: 10,
          text:
              'Бүү ай, учир нь Би чамтай хамт байна. Бүү сандар, учир нь Би бол чиний Бурхан. '
              'Би чамайг хүчирхэгжүүлнэ. Тийм ээ, Би чамд тусална. '
              'Тийм ээ, Би чамайг зөв баруун мутраараа дэмжинэ.',
          isFavorite: true,
        ),
      ];

  /// Sample songs
  static List<SongModel> get songs => const [
        SongModel(
          id: 's1',
          title: 'Эзэн миний хоньчин',
          artist: 'Магтаалын баг',
          duration: Duration(minutes: 4, seconds: 32),
          category: SongCategory.worship,
          isFavorite: true,
          lyrics: 'Эзэн миний хоньчин\nБи дутагдахгүй\n'
              'Ногоон бэлчээрт\nНамайг хэвтүүлнэ...',
        ),
        SongModel(
          id: 's2',
          title: 'Алдар Бурханд',
          artist: 'Магтаалын баг',
          duration: Duration(minutes: 3, seconds: 45),
          category: SongCategory.praise,
        ),
        SongModel(
          id: 's3',
          title: 'Миний зүрхний дуу',
          artist: 'Залуучуудын баг',
          duration: Duration(minutes: 4, seconds: 12),
          category: SongCategory.contemporary,
          isFavorite: true,
        ),
        SongModel(
          id: 's4',
          title: 'Бурханы хайр',
          artist: 'Хүүхдийн найрал',
          duration: Duration(minutes: 2, seconds: 58),
          category: SongCategory.children,
        ),
        SongModel(
          id: 's5',
          title: 'Агуу их Бурхан',
          artist: 'Сүмийн найрал',
          duration: Duration(minutes: 5, seconds: 15),
          category: SongCategory.hymn,
        ),
        SongModel(
          id: 's6',
          title: 'Магтаалын дуу',
          artist: 'Магтаалын баг',
          duration: Duration(minutes: 3, seconds: 22),
          category: SongCategory.praise,
        ),
      ];

  /// Sample sermons
  static List<SermonModel> get sermons => [
        SermonModel(
          id: 'sr1',
          title: 'Итгэлийн хүч',
          preacher: 'Пастор Батбаяр',
          date: DateTime.now().subtract(const Duration(days: 7)),
          duration: const Duration(minutes: 45, seconds: 30),
          description: 'Итгэлээр амьдрах тухай номлол',
          bibleReference: 'Еврей 11:1-6',
          isFavorite: true,
        ),
        SermonModel(
          id: 'sr2',
          title: 'Хайрын зам',
          preacher: 'Пастор Оюунбилэг',
          date: DateTime.now().subtract(const Duration(days: 14)),
          duration: const Duration(minutes: 38, seconds: 15),
          description: 'Бурханы хайр, бидний хариу хайрын тухай',
          bibleReference: '1 Коринт 13',
        ),
        SermonModel(
          id: 'sr3',
          title: 'Залбирлын амьдрал',
          preacher: 'Пастор Батбаяр',
          date: DateTime.now().subtract(const Duration(days: 21)),
          duration: const Duration(minutes: 42, seconds: 45),
          description: 'Залбирлын ач холбогдол ба практик',
          bibleReference: 'Матай 6:5-15',
        ),
        SermonModel(
          id: 'sr4',
          title: 'Ариун Сүнсний бэлэг',
          preacher: 'Пастор Энхболд',
          date: DateTime.now().subtract(const Duration(days: 28)),
          duration: const Duration(minutes: 50, seconds: 10),
          description: 'Ариун Сүнсний бэлгүүдийн тухай',
          bibleReference: '1 Коринт 12',
          series: const SermonSeries(
            id: 'ss1',
            name: 'Ариун Сүнс',
            description: 'Ариун Сүнсний тухай цуврал номлол',
          ),
        ),
      ];

  /// Get song by ID
  static SongModel? getSongById(String id) {
    try {
      return songs.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
