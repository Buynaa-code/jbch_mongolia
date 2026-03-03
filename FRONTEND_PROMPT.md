# Church Mobile Application Frontend - Implementation Prompt

## Overview
Сүмийн гар утасны аппликейшн (Flutter) - REST API backend-тэй холбогдох Clean Architecture бүтэцтэй frontend хөгжүүлэлт.

**Backend API URL:** `http://localhost:5001/api`

---

## Project Structure

```
lib/
├── core/
│   ├── di/                  # Dependency injection (get_it + injectable)
│   ├── error/               # Failures, Exceptions
│   ├── network/             # Dio client, interceptors, token storage
│   ├── router/              # GoRouter configuration
│   ├── theme/               # AppTheme, colors, text styles
│   └── utils/               # Extensions, constants, helpers
├── features/
│   ├── auth/                # Нэвтрэх, Бүртгүүлэх
│   ├── home/                # Нүүр хуудас
│   ├── events/              # Үйл явдлууд
│   ├── programs/            # Долоо хоногийн хөтөлбөр
│   ├── songs/               # Магтаалын дуунууд
│   ├── verses/              # Библийн эшлэлүүд
│   ├── profile/             # Хэрэглэгчийн профайл
│   └── favorites/           # Дуртай зүйлс
├── shared/
│   ├── widgets/             # Shared widgets
│   └── extensions/          # Dart extensions
└── main.dart
```

---

## API Endpoints & Data Models

### 1. Authentication (Нэвтрэлт)

**Endpoints:**
```
POST /api/auth/register     - Бүртгүүлэх
POST /api/auth/login        - Нэвтрэх
POST /api/auth/refresh-token - Token шинэчлэх
POST /api/auth/logout       - Гарах (Protected)
GET  /api/auth/me           - Миний мэдээлэл (Protected)
```

**Register Request:**
```json
{
  "name": "Батболд",
  "email": "batbold@example.com",
  "password": "123456",
  "phone": "99001122"
}
```

**Login Request:**
```json
{
  "email": "batbold@example.com",
  "password": "123456"
}
```

**Auth Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "...",
      "name": "Батболд",
      "email": "batbold@example.com",
      "role": "user"
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

**User Model:**
```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final String? avatar;
  final List<String> favoriteSongs;
  final List<String> favoriteVerses;
  final List<String> registeredEvents;
}
```

---

### 2. Events (Үйл явдлууд)

**Endpoints:**
```
GET    /api/events              - Бүх үйл явдлууд (pagination)
GET    /api/events/upcoming     - Удахгүй болох
GET    /api/events/featured     - Онцлох үйл явдлууд
GET    /api/events/type/:type   - Төрлөөр шүүх
GET    /api/events/:id          - Дэлгэрэнгүй
POST   /api/events/:id/register - Бүртгүүлэх (Protected)
DELETE /api/events/:id/register - Бүртгэлээс гарах (Protected)
```

**Event Types:**
- `seminar` - Семинар
- `worship` - Мөргөл
- `youth` - Залуучуудын цуглаан
- `prayer` - Залбирлын цуглаан
- `bible_study` - Библи судлал
- `fellowship` - Нөхөрлөл
- `conference` - Бага хурал
- `other` - Бусад

**Event Model:**
```dart
class EventModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final LocationModel location;
  final String? image;
  final SpeakerModel? speaker;
  final int? capacity;
  final int registrationCount;
  final bool isFeatured;
  final bool isAvailable;
  final bool isUpcoming;
}

class LocationModel {
  final String name;
  final String? address;
  final CoordinatesModel? coordinates;
}

class SpeakerModel {
  final String? name;
  final String? title;
  final String? bio;
  final String? image;
}
```

---

### 3. Programs (Долоо хоногийн хөтөлбөр)

**Endpoints:**
```
GET /api/programs              - Бүх хөтөлбөр
GET /api/programs/current-week - Энэ долоо хоногийн
GET /api/programs/day/:day     - Өдрөөр (0=Ням, 1=Даваа, ...)
GET /api/programs/service/:type - Үйлчлэлийн төрлөөр
GET /api/programs/:id          - Дэлгэрэнгүй
```

**Service Types:**
- `sunday_morning` - Ням гарагийн өглөөний мөргөл
- `sunday_evening` - Ням гарагийн оройн мөргөл
- `wednesday` - Лхагва гарагийн цуглаан
- `friday_youth` - Баасан гарагийн залуучуудын цуглаан
- `saturday` - Бямба гарагийн цуглаан
- `special` - Тусгай үйлчлэл

**Program Model:**
```dart
class ProgramModel {
  final String id;
  final DateTime weekOf;
  final int dayOfWeek; // 0-6
  final String serviceType;
  final String title;
  final String? theme;
  final List<ProgramItemModel> items;
  final String? notes;
}

class ProgramItemModel {
  final String time;
  final String title;
  final String? description;
  final String? speaker;
  final int order;
}
```

---

### 4. Verses (Библийн эшлэлүүд)

**Endpoints:**
```
GET  /api/verses                - Бүх эшлэлүүд
GET  /api/verses/verse-of-week  - Долоо хоногийн эшлэл
GET  /api/verses/themes         - Бүх сэдвүүд
GET  /api/verses/theme/:theme   - Сэдвээр шүүх
GET  /api/verses/book/:book     - Номоор шүүх
GET  /api/verses/:id            - Дэлгэрэнгүй
POST /api/verses/:id/favorite   - Дуртай болгох (Protected)
```

**Verse Themes:**
- `love` - Хайр
- `faith` - Итгэл
- `hope` - Найдвар
- `salvation` - Аврал
- `prayer` - Залбирал
- `wisdom` - Мэргэн ухаан
- `strength` - Хүч чадал
- `peace` - Амар тайван
- `forgiveness` - Уучлал
- `grace` - Нигүүлсэл

**Verse Model:**
```dart
class VerseModel {
  final String id;
  final String reference; // "Иохан 3:16"
  final String book;
  final int chapter;
  final int verseStart;
  final int? verseEnd;
  final String text;
  final String? textMongolian;
  final String theme;
  final bool isVerseOfWeek;
  final DateTime? weekOf;
  final String? reflection;
  final int favoriteCount;
}
```

---

### 5. Songs (Магтаалын дуунууд)

**Endpoints:**
```
GET  /api/songs              - Бүх дуунууд
GET  /api/songs/search?q=    - Хайлт
GET  /api/songs/popular      - Алдартай дуунууд
GET  /api/songs/featured     - Онцлох дуунууд
GET  /api/songs/genre/:genre - Төрлөөр шүүх
GET  /api/songs/:id          - Дэлгэрэнгүй
POST /api/songs/:id/favorite - Дуртай болгох (Protected)
POST /api/songs/:id/play     - Тоглуулсан тоо нэмэх
```

**Song Genres:**
- `worship` - Мөргөлийн дуу
- `praise` - Магтаал
- `hymn` - Сонгодог магтаал
- `gospel` - Сайн мэдээний дуу
- `contemporary` - Орчин үеийн
- `traditional` - Уламжлалт
- `children` - Хүүхдийн дуу

**Song Model:**
```dart
class SongModel {
  final String id;
  final String title;
  final String artist;
  final String? album;
  final String genre;
  final String? lyrics;
  final String? lyricsMongolian;
  final String? audioUrl;
  final String? videoUrl;
  final String? coverImage;
  final int? duration; // seconds
  final String? key; // Musical key
  final int? tempo; // BPM
  final int playCount;
  final bool isFeatured;
  final int favoriteCount;
  final List<String> tags;
}
```

---

### 6. Sermons (Номлолууд)

**Endpoints:**
```
GET  /api/sermons              - Бүх номлолууд
GET  /api/sermons/search?q=    - Хайлт
GET  /api/sermons/recent       - Сүүлийн номлолууд
GET  /api/sermons/featured     - Онцлох номлолууд
GET  /api/sermons/series       - Бүх цуврал
GET  /api/sermons/series/:name - Цувралаар шүүх
GET  /api/sermons/preacher/:name - Номлогчоор шүүх
GET  /api/sermons/:id          - Дэлгэрэнгүй
POST /api/sermons/:id/favorite - Дуртай болгох (Protected)
POST /api/sermons/:id/play     - Тоглуулсан тоо нэмэх
```

**Sermon Model:**
```dart
class SermonModel {
  final String id;
  final String title;
  final String preacher;
  final DateTime date;
  final int? duration; // seconds
  final String? audioUrl;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? description;
  final String? bibleReference;
  final String? series;
  final List<String> tags;
  final int playCount;
  final bool isFeatured;
  final int favoriteCount;
}
```

---

### 7. User Profile (Хэрэглэгчийн профайл)

**Endpoints:**
```
GET /api/users/profile           - Профайл авах (Protected)
PUT /api/users/profile           - Профайл шинэчлэх (Protected)
PUT /api/users/change-password   - Нууц үг солих (Protected)
GET /api/users/favorites         - Бүх дуртай зүйлс (Protected)
GET /api/users/favorites/songs   - Дуртай дуунууд (Protected)
GET /api/users/favorites/verses  - Дуртай эшлэлүүд (Protected)
GET /api/users/favorites/sermons - Дуртай номлолууд (Protected)
```

---

## Features to Implement

### Feature 1: Authentication (Нэвтрэлт)
**Pages:**
- `LoginPage` - Нэвтрэх хуудас
- `RegisterPage` - Бүртгүүлэх хуудас
- `ForgotPasswordPage` - Нууц үг сэргээх (optional)

**Requirements:**
- Email, password validation
- Token storage (SharedPreferences/SecureStorage)
- Auto-login with refresh token
- Logout functionality

---

### Feature 2: Home (Нүүр хуудас)
**Widgets:**
- Долоо хоногийн эшлэл (Verse of Week card)
- Удахгүй болох үйл явдлууд (Upcoming events carousel)
- Өнөөдрийн хөтөлбөр (Today's program)
- Онцлох дуунууд (Featured songs)
- Шуурхай холбоосууд (Quick links)

---

### Feature 3: Events (Үйл явдлууд)
**Pages:**
- `EventsListPage` - Үйл явдлын жагсаалт
- `EventDetailPage` - Дэлгэрэнгүй хуудас

**Features:**
- Filter by type
- Search
- Register/Unregister
- Calendar view (optional)
- Share event

---

### Feature 4: Programs (Хөтөлбөр)
**Pages:**
- `WeeklyProgramPage` - Долоо хоногийн хөтөлбөр

**Features:**
- Day selector (Ням, Даваа, ...)
- Program timeline view
- Service type filter

---

### Feature 5: Songs (Дуунууд)
**Pages:**
- `SongsListPage` - Дууны жагсаалт
- `SongDetailPage` - Дууны үг, дэлгэрэнгүй
- `SongPlayerPage` - Дуу тоглуулах (optional)

**Features:**
- Search songs
- Filter by genre
- Favorite toggle
- Lyrics display (scrollable)
- Audio player (if audioUrl exists)

---

### Feature 6: Verses (Эшлэлүүд)
**Pages:**
- `VersesListPage` - Эшлэлүүдийн жагсаалт
- `VerseDetailPage` - Дэлгэрэнгүй

**Features:**
- Verse of the week highlight
- Filter by theme
- Filter by book
- Favorite toggle
- Share verse
- Copy to clipboard

---

### Feature 7: Sermons (Номлолууд)
**Pages:**
- `SermonsListPage` - Номлолын жагсаалт
- `SermonDetailPage` - Дэлгэрэнгүй хуудас
- `SermonPlayerPage` - Номлол тоглуулах

**Features:**
- Search sermons
- Filter by preacher
- Filter by series
- Favorite toggle
- Audio/Video player
- Bible reference link

---

### Feature 8: Profile (Профайл)
**Pages:**
- `ProfilePage` - Хэрэглэгчийн профайл
- `EditProfilePage` - Профайл засах
- `ChangePasswordPage` - Нууц үг солих
- `FavoritesPage` - Дуртай зүйлс

**Features:**
- View/Edit profile
- View favorite songs, verses & sermons
- View registered events
- Settings
- Logout

---

## Network Layer Implementation

### Dio Client Setup:
```dart
// lib/core/network/dio_client.dart
class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:5001/api',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LogInterceptor());
  }
}
```

### Auth Interceptor:
```dart
// lib/core/network/auth_interceptor.dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = TokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Try refresh token
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry request
        return handler.resolve(await _retry(err.requestOptions));
      }
    }
    handler.next(err);
  }
}
```

---

## UI/UX Requirements

### Design System:
- Primary Color: Сүмийн брэнд өнгө
- Font: Google Fonts (Mongolian support)
- Icons: Material Icons эсвэл custom icons
- Spacing: 8px grid system

### Mongolian UI Text Examples:
```dart
// lib/core/constants/app_strings.dart
class AppStrings {
  // Auth
  static const login = 'Нэвтрэх';
  static const register = 'Бүртгүүлэх';
  static const email = 'Имэйл';
  static const password = 'Нууц үг';
  static const forgotPassword = 'Нууц үгээ мартсан уу?';

  // Navigation
  static const home = 'Нүүр';
  static const events = 'Үйл явдал';
  static const library = 'Сан';
  static const songs = 'Дуунууд';
  static const verses = 'Эшлэлүүд';
  static const sermons = 'Номлолууд';
  static const profile = 'Профайл';

  // Events
  static const upcomingEvents = 'Удахгүй болох үйл явдлууд';
  static const registerForEvent = 'Бүртгүүлэх';
  static const registered = 'Бүртгүүлсэн';

  // Songs
  static const searchSongs = 'Дуу хайх...';
  static const lyrics = 'Дууны үг';
  static const popularSongs = 'Алдартай дуунууд';

  // Verses
  static const verseOfWeek = 'Долоо хоногийн эшлэл';
  static const memorize = 'Цээжлэх';

  // Sermons
  static const recentSermons = 'Сүүлийн номлолууд';
  static const sermonSeries = 'Номлолын цуврал';
  static const preacher = 'Номлогч';
  static const bibleReference = 'Библийн эшлэл';

  // Common
  static const loading = 'Уншиж байна...';
  static const error = 'Алдаа гарлаа';
  static const retry = 'Дахин оролдох';
  static const noData = 'Мэдээлэл олдсонгүй';
  static const save = 'Хадгалах';
  static const cancel = 'Цуцлах';
  static const favorite = 'Дуртай';
  static const share = 'Хуваалцах';
}
```

---

## State Management (BLoC/Cubit)

### Example Auth Cubit:
```dart
// lib/features/auth/presentation/bloc/auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}
```

---

## Pagination Support

API returns paginated data:
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 50,
    "pages": 5
  }
}
```

Use `?page=1&limit=10` query params for pagination.

---

## Error Handling

API error response format:
```json
{
  "success": false,
  "message": "Error message",
  "errors": ["Validation error 1", "Validation error 2"]
}
```

Handle errors gracefully with user-friendly Mongolian messages.

---

## Testing Checklist

1. [ ] Auth: Register, Login, Logout, Auto-refresh token
2. [ ] Events: List, Detail, Register, Filter
3. [ ] Programs: Current week, Day filter
4. [ ] Songs: List, Search, Detail, Favorite, Play count
5. [ ] Verses: List, Verse of week, Theme filter, Favorite
6. [ ] Sermons: List, Search, Detail, Favorite, Play count
7. [ ] Profile: View, Edit, Change password, Favorites
8. [ ] Offline mode (optional): Cache data locally
9. [ ] Push notifications (optional): Event reminders

---

## Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dartz: ^0.10.1
  get_it: ^7.6.4
  injectable: ^2.3.2
  dio: ^5.3.2
  go_router: ^12.0.0
  google_fonts: ^6.1.0
  shared_preferences: ^2.2.1
  flutter_secure_storage: ^9.0.0
  cached_network_image: ^3.3.0
  flutter_animate: ^4.3.0
  shimmer: ^3.0.0
  intl: ^0.18.1
```

---

## Notes

- Backend API runs on `http://localhost:5001`
- For Android emulator use `http://10.0.2.2:5001`
- For iOS simulator use `http://localhost:5001`
- All protected routes require `Authorization: Bearer <token>` header
- Token expires in 15 minutes, use refresh token to get new access token
- UI text must be in Mongolian (Cyrillic)
- Code comments and variable names in English
