import 'dart:math';
import 'dart:io';

// Simple Logger implementation
enum LogLevel { debug, info, warning, error }

class SimpleLogger {
  final String name;
  static LogLevel minLevel = LogLevel.info;

  SimpleLogger(this.name);

  void _log(
    LogLevel level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (level.index < minLevel.index) return;

    String timestamp = DateTime.now().toString().substring(11, 19);
    String levelName = level.name.toUpperCase().padRight(7);

    stdout.writeln('[$levelName] $timestamp - $name: $message');

    if (error != null) {
      stdout.writeln('Error: $error');
    }
    if (stackTrace != null) {
      stdout.writeln('Stack trace: $stackTrace');
    }
  }

  void debug(String message) => _log(LogLevel.debug, message);
  void info(String message) => _log(LogLevel.info, message);
  void warning(String message, [Object? error]) =>
      _log(LogLevel.warning, message, error);
  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _log(LogLevel.error, message, error, stackTrace);
}

final SimpleLogger logger = SimpleLogger('UserService');

// Giả lập API endpoint trả về danh sách người dùng
Future<List<String>> fetchUsersFromAPI() async {
  logger.info('🔄 Đang kết nối tới API để lấy danh sách người dùng...');

  // Giả lập thời gian phản hồi API (1-3 giây)
  int delay = 1 + Random().nextInt(3);
  logger.debug('API delay: ${delay}s');

  await Future.delayed(Duration(seconds: delay));

  // Giả lập dữ liệu từ API
  List<String> users = [
    'Nguyễn Văn An',
    'Trần Thị Bình',
    'Lê Hoàng Cường',
    'Phạm Thị Dung',
    'Hoàng Văn Em',
    'Vũ Thị Phương',
    'Đặng Minh Quang',
    'Bùi Thị Hoa',
    'Ngô Văn Inh',
    'Dương Thị Kiều',
  ];

  // Giả lập việc shuffle danh sách và lấy ngẫu nhiên 5-8 users
  users.shuffle();
  int count = 5 + Random().nextInt(4); // 5-8 users
  List<String> result = users.take(count).toList();

  logger.info('✅ API trả về ${result.length} người dùng');
  logger.debug('Users: ${result.join(", ")}');

  return result;
}

// Giả lập API lấy thông tin chi tiết của một user
Future<Map<String, dynamic>> fetchUserDetails(String userName) async {
  logger.debug('🔍 Lấy thông tin chi tiết cho: $userName');

  // Giả lập thời gian truy vấn database
  await Future.delayed(Duration(milliseconds: 200 + Random().nextInt(300)));

  // Tạo thông tin giả lập
  List<String> roles = ['Admin', 'User', 'Moderator', 'Guest'];
  List<String> departments = ['IT', 'HR', 'Sales', 'Marketing', 'Finance'];

  return {
    'name': userName,
    'id': 1000 + Random().nextInt(9000),
    'email': userName.toLowerCase().replaceAll(' ', '.') + '@company.com',
    'role': roles[Random().nextInt(roles.length)],
    'department': departments[Random().nextInt(departments.length)],
    'isActive': Random().nextBool(),
    'lastLogin': DateTime.now().subtract(Duration(days: Random().nextInt(30))),
  };
}

// Hàm chính sử dụng async/await để lấy và xử lý danh sách users
Future<void> processUserList() async {
  try {
    logger.info('🚀 Bắt đầu xử lý danh sách người dùng');

    // Lấy danh sách người dùng từ API
    List<String> users = await fetchUsersFromAPI();

    logger.info('📋 Danh sách người dùng nhận được:');
    logger.info('=' * 50);

    // In lần lượt từng tên người dùng
    for (int i = 0; i < users.length; i++) {
      String user = users[i];
      logger.info('${i + 1}. $user');

      // Tạo delay nhỏ để mô phỏng việc xử lý từng user
      await Future.delayed(Duration(milliseconds: 300));
    }

    logger.info('=' * 50);
    logger.info('✅ Đã in xong ${users.length} người dùng');
  } catch (error, stackTrace) {
    logger.error('❌ Lỗi khi xử lý danh sách người dùng', error, stackTrace);
  }
}

// Hàm lấy thông tin chi tiết cho tất cả users (demo async/await nâng cao)
Future<void> processUsersWithDetails() async {
  try {
    logger.info('🔍 Lấy thông tin chi tiết cho tất cả người dùng');

    // Bước 1: Lấy danh sách users
    List<String> users = await fetchUsersFromAPI();

    // Bước 2: Lấy thông tin chi tiết cho từng user
    logger.info('📊 Thông tin chi tiết:');
    logger.info('=' * 60);

    for (String userName in users) {
      // Sử dụng await để đợi thông tin chi tiết của từng user
      Map<String, dynamic> userDetails = await fetchUserDetails(userName);

      // In thông tin được format đẹp
      logger.info('👤 ${userDetails['name']}');
      logger.info('   📧 ${userDetails['email']}');
      logger.info(
        '   🏢 ${userDetails['department']} - ${userDetails['role']}',
      );
      logger.info(
        '   📊 Status: ${userDetails['isActive'] ? "Active" : "Inactive"}',
      );
      logger.info(
        '   🕒 Last login: ${userDetails['lastLogin'].toString().substring(0, 16)}',
      );
      logger.info('   🆔 ID: ${userDetails['id']}');
      logger.info('');
    }

    logger.info('=' * 60);
    logger.info(
      '✅ Hoàn thành xử lý ${users.length} người dùng với thông tin chi tiết',
    );
  } catch (error, stackTrace) {
    logger.error(
      '❌ Lỗi khi lấy thông tin chi tiết người dùng',
      error,
      stackTrace,
    );
  }
}

// Hàm demo xử lý song song (concurrent processing)
Future<void> processConcurrentUsers() async {
  try {
    logger.info('⚡ Demo xử lý song song nhiều API calls');

    // Lấy danh sách users trước
    List<String> users = await fetchUsersFromAPI();

    // Tạo nhiều Future cùng lúc (không await ngay)
    List<Future<Map<String, dynamic>>> futures =
        users.map((userName) => fetchUserDetails(userName)).toList();

    logger.info('🔄 Đang xử lý ${futures.length} users song song...');

    // Đợi tất cả Future hoàn thành cùng lúc
    List<Map<String, dynamic>> allUserDetails = await Future.wait(futures);

    logger.info('📋 Kết quả xử lý song song:');
    logger.info('=' * 50);

    for (var userDetail in allUserDetails) {
      logger.info('${userDetail['name']} (${userDetail['department']})');
    }

    logger.info('=' * 50);
    logger.info('⚡ Xử lý song song hoàn thành!');
  } catch (error, stackTrace) {
    logger.error('❌ Lỗi trong xử lý song song', error, stackTrace);
  }
}

// Hàm main với error handling toàn diện
Future<void> main() async {
  // Uncomment để xem debug logs
  // SimpleLogger.minLevel = LogLevel.debug;

  logger.info('=== DEMO ASYNC/AWAIT VỚI DART ===');

  try {
    // Demo 1: Cơ bản - Lấy và in danh sách users
    await processUserList();

    logger.info('');
    logger.info('⏳ Chờ 2 giây trước demo tiếp theo...');
    await Future.delayed(Duration(seconds: 2));

    // Demo 2: Nâng cao - Lấy thông tin chi tiết
    await processUsersWithDetails();

    logger.info('');
    logger.info('⏳ Chờ 2 giây trước demo cuối...');
    await Future.delayed(Duration(seconds: 2));

    // Demo 3: Xử lý song song
    await processConcurrentUsers();

    logger.info('');
    logger.info('🎉 Tất cả demo đã hoàn thành thành công!');
  } catch (error, stackTrace) {
    logger.error('💥 Lỗi không mong đợi trong main', error, stackTrace);
  }
}
