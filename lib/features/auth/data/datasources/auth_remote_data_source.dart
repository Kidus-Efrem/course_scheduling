import 'package:course_scheduling/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailPassword({
    // required String name,
    required String email,
    required String password,
  });
  Future<Map<String, dynamic>> getProfile({required String userId});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException(('user is null!'));
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getProfile({required String userId}) async {
    try {
      final response = await supabaseClient
          .from('profile')
          .select()
          .eq('user_id', userId)
          .single();
      if (response == null) {
        throw const ServerException("Profile not found");
      }
      return response as Map<String, dynamic>;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
