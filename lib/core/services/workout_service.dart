import 'dart:convert';

import '../../data/local/UserPreferences.dart';
import '../../data/remote/ApiService.dart';
import 'package:http/http.dart' as http;

import '../models/workout.dart';

class WorkoutService {


  Future<List<Workout>> getAllWorkouts(String date) async {
    final url = Uri.parse('${ApiService.URL_BASE}/workouts/$date');

    var cookie = await UserPreferences().getCookie();

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json", 'Cookie': cookie!},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = json.decode(response.body);

      // Lấy danh sách workoutPlans từ đối tượng JSON
      final List<dynamic> workoutsJson = responseJson['workoutPlans'];
      print((workoutsJson[0].runtimeType));

      // Chuyển đổi danh sách thành List<Workout>
      return workoutsJson.map((workout) => Workout.fromJson(workout)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }

  // update workout status return String
  Future<Workout> updateWorkoutStatus(int id, bool status) async {
    // Lấy token từ UserPreferences
    var token = await UserPreferences().getToken();

    // Tạo URL với id và token
    final url = Uri.parse('${ApiService.URL_BASE}/workouts/complete/$id?Authorization=$token');

    // Lấy cookie nếu cần thiết
    var cookie = await UserPreferences().getCookie();

    // Gửi yêu cầu HTTP
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Cookie': cookie!,
      },
    );

    // Kiểm tra phản hồi từ server
    if (response.statusCode == 200) {
      // Giải mã phản hồi từ server
      final Map<String, dynamic> responseJson = json.decode(response.body);

      // Trả về đối tượng Workout được cập nhật
      return Workout.fromJson(responseJson);
    } else {
      // Ném lỗi nếu có vấn đề
      throw Exception('Failed to update workout status: ${response.statusCode} - ${response.body}');
    }
  }



// Future<Map<String, dynamic>> getWorkoutDetails(int id) async {
  //   final url = Uri.parse('${ApiService.URL_BASE}/workout/details/$id');
  //   print(url);
  //   final response = await http.get(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to load workout details');
  //   }
  // }
}
