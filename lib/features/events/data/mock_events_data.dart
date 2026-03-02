import '../../../shared/models/event_model.dart';

/// Mock data for the Events feature
abstract final class MockEventsData {
  /// All upcoming events
  static List<EventModel> get upcomingEvents => [
        EventModel(
          id: '1',
          title: 'Библи судлалын семинар',
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
          title: 'Залуучуудын мөргөлийн үдэш',
          description:
              'Залуучуудад зориулсан магтаал, мөргөлийн үдэш. '
              'Тусгай зочин: Пастор Батбаяр',
          dateTime: DateTime.now().add(const Duration(days: 5, hours: 18)),
          location: 'Залуучуудын танхим',
          type: EventType.youthGroup,
          isUpcoming: true,
        ),
        EventModel(
          id: '3',
          title: 'Гэр бүлийн баяр',
          description:
              'Гэр бүлүүдэд зориулсан онцгой арга хэмжээ. '
              'Тоглоом, уралдаан, хамтын хоол.',
          dateTime: DateTime.now().add(const Duration(days: 10, hours: 11)),
          location: 'Сүмийн талбай',
          type: EventType.fellowship,
          isUpcoming: true,
        ),
        EventModel(
          id: '4',
          title: 'Залбирлын шөнө',
          description:
              'Монгол улсын төлөөх 24 цагийн залбирлын шөнө. '
              'Хүссэн цагтаа ирж, хүссэн хугацаандаа залбирна.',
          dateTime: DateTime.now().add(const Duration(days: 14, hours: 20)),
          location: 'Залбирлын танхим',
          type: EventType.prayer,
          isUpcoming: true,
        ),
        EventModel(
          id: '5',
          title: 'Христэч хөгжмийн концерт',
          description:
              'Бүс нутгийн христэч хөгжмийн баг нэгдэн концерт тоглоно. '
              'Үнэгүй, бүх хүнд нээлттэй.',
          dateTime: DateTime.now().add(const Duration(days: 21, hours: 17)),
          location: 'Их танхим',
          type: EventType.special,
          isUpcoming: true,
        ),
        EventModel(
          id: '6',
          title: 'Библи судлал: Ром захидал',
          description:
              '8 долоо хоногийн Ром захидлын судалгаа эхэлж байна. '
              'Сурах материал үнэгүй.',
          dateTime: DateTime.now().add(const Duration(days: 7, hours: 19)),
          location: 'Судлалын танхим',
          type: EventType.bibleStudy,
          isUpcoming: true,
        ),
      ];

  /// Past events
  static List<EventModel> get pastEvents => [
        EventModel(
          id: 'p1',
          title: 'Шинэ жилийн мөргөл',
          description: 'Шинэ жилийн анхны мөргөл',
          dateTime: DateTime.now().subtract(const Duration(days: 30)),
          location: 'Их танхим',
          type: EventType.worship,
          isUpcoming: false,
        ),
        EventModel(
          id: 'p2',
          title: 'Хүүхдийн баяр',
          description: 'Хүүхдийн өдөрт зориулсан арга хэмжээ',
          dateTime: DateTime.now().subtract(const Duration(days: 45)),
          location: 'Сүмийн талбай',
          type: EventType.special,
          isUpcoming: false,
        ),
      ];

  /// Get event by ID
  static EventModel? getEventById(String id) {
    try {
      return [...upcomingEvents, ...pastEvents].firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
