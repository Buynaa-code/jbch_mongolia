# Backend API Reference - Church Mobile App

**Base URL:** `http://localhost:5001/api`

---

## Authentication Endpoints

### Register
```
POST /api/auth/register
Content-Type: application/json

{
  "name": "Батболд",
  "email": "batbold@example.com",
  "password": "123456",
  "phone": "99001122"
}
```

### Login
```
POST /api/auth/login
Content-Type: application/json

{
  "email": "batbold@example.com",
  "password": "123456"
}

Response:
{
  "success": true,
  "data": {
    "user": { "id", "name", "email", "role" },
    "accessToken": "eyJ...",
    "refreshToken": "eyJ..."
  }
}
```

### Refresh Token
```
POST /api/auth/refresh-token
{
  "refreshToken": "eyJ..."
}
```

### Get Current User (Protected)
```
GET /api/auth/me
Authorization: Bearer <accessToken>
```

### Logout (Protected)
```
POST /api/auth/logout
Authorization: Bearer <accessToken>
```

---

## Events Endpoints

### List Events
```
GET /api/events
GET /api/events?page=1&limit=10
GET /api/events?type=seminar
```

### Upcoming Events
```
GET /api/events/upcoming
GET /api/events/upcoming?limit=5
```

### Featured Events
```
GET /api/events/featured
```

### Events by Type
```
GET /api/events/type/seminar
GET /api/events/type/worship
GET /api/events/type/youth
```

### Event Detail
```
GET /api/events/:id
```

### Register for Event (Protected)
```
POST /api/events/:id/register
Authorization: Bearer <token>
```

### Unregister from Event (Protected)
```
DELETE /api/events/:id/register
Authorization: Bearer <token>
```

**Event Types:** `seminar`, `worship`, `youth`, `prayer`, `bible_study`, `fellowship`, `conference`, `other`

**Event Response Model:**
```json
{
  "id": "...",
  "title": "Библи судлах семинар",
  "description": "...",
  "type": "seminar",
  "startDate": "2024-03-15T09:00:00Z",
  "endDate": "2024-03-15T17:00:00Z",
  "location": {
    "name": "Сүмийн байр",
    "address": "УБ, СБД"
  },
  "imageUrl": "https://...",
  "speaker": {
    "name": "Пастор Болд",
    "title": "Ахлагч пастор"
  },
  "capacity": 100,
  "registrationCount": 45,
  "isFeatured": true,
  "isUpcoming": true,
  "isAvailable": true
}
```

---

## Songs Endpoints

### List Songs
```
GET /api/songs
GET /api/songs?page=1&limit=20
```

### Search Songs
```
GET /api/songs/search?q=Магтаал
```

### Popular Songs
```
GET /api/songs/popular?limit=10
```

### Featured Songs
```
GET /api/songs/featured
```

### Songs by Genre
```
GET /api/songs/genre/worship
GET /api/songs/genre/praise
```

### Song Detail
```
GET /api/songs/:id
```

### Toggle Favorite (Protected)
```
POST /api/songs/:id/favorite
Authorization: Bearer <token>

Response: { "isFavorited": true }
```

### Increment Play Count
```
POST /api/songs/:id/play
```

**Song Genres:** `worship`, `praise`, `hymn`, `gospel`, `contemporary`, `traditional`, `children`

**Song Response Model:**
```json
{
  "id": "...",
  "title": "Эрхэм нэр",
  "artist": "Worship Team",
  "album": "Магтаал 2024",
  "genre": "worship",
  "lyrics": "Дууны үг...",
  "lyricsMongolian": "...",
  "audioUrl": "https://...",
  "videoUrl": "https://...",
  "coverImage": "https://...",
  "duration": 245,
  "key": "G",
  "tempo": 72,
  "playCount": 1520,
  "isFeatured": true,
  "favoriteCount": 89,
  "tags": ["slow", "prayer"]
}
```

---

## Sermons Endpoints

### List Sermons
```
GET /api/sermons
GET /api/sermons?page=1&limit=10
```

### Search Sermons
```
GET /api/sermons/search?q=Итгэл
```

### Recent Sermons
```
GET /api/sermons/recent?limit=10
```

### Featured Sermons
```
GET /api/sermons/featured
```

### Sermons by Preacher
```
GET /api/sermons/preacher/Болд
```

### All Series
```
GET /api/sermons/series
```

### Sermons by Series
```
GET /api/sermons/series/Итгэлийн суурь
```

### Sermon Detail
```
GET /api/sermons/:id
```

### Toggle Favorite (Protected)
```
POST /api/sermons/:id/favorite
Authorization: Bearer <token>
```

### Increment Play Count
```
POST /api/sermons/:id/play
```

**Sermon Response Model:**
```json
{
  "id": "...",
  "title": "Итгэлээр амьдрах нь",
  "preacher": "Пастор Болд",
  "date": "2024-03-10T10:00:00Z",
  "duration": 2700,
  "audioUrl": "https://...",
  "videoUrl": "https://...",
  "thumbnailUrl": "https://...",
  "description": "Номлолын тайлбар...",
  "bibleReference": "Еврей 11:1-6",
  "series": "Итгэлийн суурь",
  "tags": ["итгэл", "амьдрал"],
  "playCount": 234,
  "isFeatured": true,
  "favoriteCount": 45
}
```

---

## Verses Endpoints

### List Verses
```
GET /api/verses
GET /api/verses?page=1&limit=20
```

### Verse of the Week
```
GET /api/verses/verse-of-week
```

### All Themes
```
GET /api/verses/themes
```

### Verses by Theme
```
GET /api/verses/theme/faith
GET /api/verses/theme/love
```

### Verses by Book
```
GET /api/verses/book/Иохан
```

### Verse Detail
```
GET /api/verses/:id
```

### Toggle Favorite (Protected)
```
POST /api/verses/:id/favorite
Authorization: Bearer <token>
```

**Verse Themes:** `love`, `faith`, `hope`, `salvation`, `prayer`, `wisdom`, `strength`, `peace`, `forgiveness`, `grace`

**Verse Response Model:**
```json
{
  "id": "...",
  "reference": "Иохан 3:16",
  "book": "Иохан",
  "chapter": 3,
  "verseStart": 16,
  "verseEnd": null,
  "text": "For God so loved the world...",
  "textMongolian": "Бурхан ертөнцийг үнэхээр хайрласан...",
  "theme": "love",
  "isVerseOfWeek": true,
  "weekOf": "2024-03-11T00:00:00Z",
  "reflection": "Энэ эшлэл биднийг...",
  "favoriteCount": 156
}
```

---

## Programs Endpoints (Weekly Program)

### List Programs
```
GET /api/programs
```

### Current Week's Program
```
GET /api/programs/current-week
```

### Program by Day
```
GET /api/programs/day/0  # Sunday
GET /api/programs/day/3  # Wednesday
```

### Program by Service Type
```
GET /api/programs/service/sunday_morning
```

### Program Detail
```
GET /api/programs/:id
```

**Service Types:** `sunday_morning`, `sunday_evening`, `wednesday`, `friday_youth`, `saturday`, `special`

**Program Response Model:**
```json
{
  "id": "...",
  "weekOf": "2024-03-11T00:00:00Z",
  "dayOfWeek": 0,
  "serviceType": "sunday_morning",
  "title": "Ням гарагийн өглөөний мөргөл",
  "theme": "Нигүүлслийн хаан",
  "items": [
    {
      "time": "09:00",
      "title": "Угтах магтаал",
      "description": "",
      "speaker": "Worship Team",
      "order": 1
    },
    {
      "time": "09:30",
      "title": "Залбирал",
      "speaker": "Ахлагч Бат",
      "order": 2
    },
    {
      "time": "10:00",
      "title": "Номлол",
      "speaker": "Пастор Болд",
      "order": 3
    }
  ],
  "notes": "Хүүхдийн ангиуд 10:00-д эхэлнэ"
}
```

---

## User Profile Endpoints (Protected)

### Get Profile
```
GET /api/users/profile
Authorization: Bearer <token>
```

### Update Profile
```
PUT /api/users/profile
Authorization: Bearer <token>

{
  "name": "Шинэ нэр",
  "phone": "99112233",
  "avatar": "https://..."
}
```

### Change Password
```
PUT /api/users/change-password
Authorization: Bearer <token>

{
  "currentPassword": "oldpass",
  "newPassword": "newpass123"
}
```

### Get All Favorites
```
GET /api/users/favorites
Authorization: Bearer <token>

Response:
{
  "songs": [...],
  "verses": [...],
  "sermons": [...]
}
```

### Get Favorite Songs
```
GET /api/users/favorites/songs
GET /api/users/favorites/songs?page=1&limit=10
```

### Get Favorite Verses
```
GET /api/users/favorites/verses
```

### Get Favorite Sermons
```
GET /api/users/favorites/sermons
```

**User Profile Model:**
```json
{
  "id": "...",
  "name": "Батболд",
  "email": "batbold@example.com",
  "phone": "99001122",
  "role": "user",
  "avatar": "https://...",
  "favoriteSongs": [...],
  "favoriteVerses": [...],
  "favoriteSermons": [...],
  "registeredEvents": [...],
  "createdAt": "2024-01-15T..."
}
```

---

## Admin Endpoints (Admin Only)

### Dashboard Stats
```
GET /api/admin/dashboard
Authorization: Bearer <admin_token>
```

### List Users
```
GET /api/admin/users
GET /api/admin/users?role=admin&isActive=true&search=болд
```

### User Details
```
GET /api/admin/users/:id
```

### Update User Role
```
PUT /api/admin/users/:id/role
{ "role": "admin" }
```

### Update User Status
```
PUT /api/admin/users/:id/status
{ "isActive": false }
```

---

## Common Response Format

### Success Response
```json
{
  "success": true,
  "message": "Success",
  "data": { ... }
}
```

### Paginated Response
```json
{
  "success": true,
  "message": "Success",
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 50,
    "pages": 5
  }
}
```

### Error Response
```json
{
  "success": false,
  "message": "Error message",
  "errors": ["Validation error 1", "Validation error 2"]
}
```

---

## Frontend Integration Notes

### Headers
```dart
// All requests
headers: {
  'Content-Type': 'application/json',
}

// Protected routes
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $accessToken',
}
```

### Token Refresh Flow
1. Access token expires → 401 Unauthorized
2. Call `/api/auth/refresh-token` with refreshToken
3. Get new accessToken + refreshToken
4. Retry original request

### Android Emulator
```
Base URL: http://10.0.2.2:5001/api
```

### iOS Simulator
```
Base URL: http://localhost:5001/api
```
