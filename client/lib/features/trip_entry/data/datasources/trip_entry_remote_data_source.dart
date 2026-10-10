import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../shared/data/trip_dto.dart';
import '../dto/new_trip_dto.dart';

class TripEntryRemoteDataSource {
  const TripEntryRemoteDataSource(this._api);

  final ApiClient _api;

  Future<SubmitResponse> submit(NewTripDto trip) async {
    final response = await _api.post('/api/trips', trip.toJson());
    final body = response.body;
    return switch (response.statusCode) {
      201 => SubmitCreated(TripDto.fromJson(body! as Map<String, dynamic>)),
      200 => SubmitReplayed(TripDto.fromJson(body! as Map<String, dynamic>)),
      409 => SubmitConflict(ConflictDto.fromJson((body! as Map<String, dynamic>)['detail'] as Map<String, dynamic>)),
      _ => throw UnexpectedStatusException(response.statusCode, body),
    };
  }
}
