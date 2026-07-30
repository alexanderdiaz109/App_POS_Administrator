import 'package:supabase_flutter/supabase_flutter.dart';

/// Cliente único de Supabase para toda la app. Solo usa la anon key
/// pública aquí (protegida por RLS) — nunca la service_role key, que
/// tiene acceso total y solo debe vivir en el backend/Edge Functions.
class SupabaseService {
  SupabaseService._();

  static const String _url = 'https://ikpmwpjfjhwqaangmmej.supabase.co';
  static const String _publishableKey = 'sb_publishable_vibJD49tjOH236pGw8DDeg_LKFM2j93';

  static Future<void> init() async {
    await Supabase.initialize(url: _url, publishableKey: _publishableKey);
  }

  static SupabaseClient get client => Supabase.instance.client;
}
