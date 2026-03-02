import '../../../shared/models/song_model.dart';
import '../../../shared/models/verse_model.dart';

/// Mock data for the Profile feature
abstract final class MockProfileData {
  /// User profile
  static UserProfile get currentUser => const UserProfile(
        id: 'u1',
        name: 'Батболд',
        email: 'batbold@email.com',
        memberSince: '2023 оны 3-р сар',
        profileImageUrl: null,
      );

  /// Favorite verses
  static List<VerseModel> get favoriteVerses => const [
        VerseModel(
          id: 'v1',
          book: 'Иохан',
          chapter: 3,
          verseStart: 16,
          text:
              'Бурхан ертөнцийг үнэхээр хайрласан тул цорын ганц Хүүгээ өгсөн.',
          isFavorite: true,
        ),
        VerseModel(
          id: 'v2',
          book: 'Дуулал',
          chapter: 23,
          verseStart: 1,
          verseEnd: 3,
          text: 'ЭЗЭН бол миний хоньчин. Би дутагдахгүй.',
          isFavorite: true,
        ),
      ];

  /// Favorite songs
  static List<SongModel> get favoriteSongs => const [
        SongModel(
          id: 's1',
          title: 'Эзэн миний хоньчин',
          artist: 'Магтаалын баг',
          duration: Duration(minutes: 4, seconds: 32),
          category: SongCategory.praise,
          isFavorite: true,
        ),
        SongModel(
          id: 's3',
          title: 'Миний зүрхний дуу',
          artist: 'Залуучуудын баг',
          duration: Duration(minutes: 4, seconds: 12),
          category: SongCategory.contemporary,
          isFavorite: true,
        ),
      ];
}

/// User profile model
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String memberSince;
  final String? profileImageUrl;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.memberSince,
    this.profileImageUrl,
  });
}
