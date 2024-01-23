import 'package:flutter_dotenv/flutter_dotenv.dart';

class CBConstants {
  static final supabaseUrl = dotenv.env['SUPABASE_URL'];
  static final supabaseKey = dotenv.env['SUPABASE_KEY'];
  static const supabaseStorageLink =
      'https://cifvlislcfhwxopfwnnf.supabase.co/storage/v1/object/public';

  static const agentIdPrefKey = 'agentId';
  static const agentNamePrefKey = 'agentName';
  static const agentFirstnamesPrefKey = 'agentFirstnames';
  static const agentEmailPrefKey = 'agentEmail';
}
