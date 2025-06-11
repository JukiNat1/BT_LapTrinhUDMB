import 'dart:math';
import 'dart:io';

// Simple Logger implementation để thay thế print()
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

// Khởi tạo logger
final SimpleLogger logger = SimpleLogger('ServerDataService');

// Hàm mô phỏng việc lấy dữ liệu từ server
Future<String> fetchDataFromServer() {
  logger.info('🔄 Đang kết nối tới server...');

  // Giả lập thời gian chờ từ 2-5 giây
  int delay = 2 + Random().nextInt(4);
  logger.debug('Delay time: ${delay}s');

  return Future.delayed(Duration(seconds: delay), () {
    // Giả lập dữ liệu trả về từ server
    List<String> sampleData = [
      'Danh sách người dùng: [John, Alice, Bob, Carol]',
      'Thông tin sản phẩm: [Laptop, Phone, Tablet, Monitor]',
      'Dữ liệu bán hàng: [100 đơn hàng hôm nay]',
      'Báo cáo thống kê: [1000 lượt truy cập]',
    ];

    String result = sampleData[Random().nextInt(sampleData.length)];
    logger.debug('Data fetched successfully: $result');
    return result;
  });
}

// Hàm mô phỏng lỗi kết nối
Future<String> fetchDataWithError() {
  logger.info('🔄 Đang thử kết nối tới server (có thể lỗi)...');

  return Future.delayed(Duration(seconds: 2), () {
    // 50% cơ hội gặp lỗi
    if (Random().nextBool()) {
      logger.warning('Connection failed - simulating server error');
      throw Exception('Lỗi kết nối server: Timeout');
    }
    logger.info('Connection successful after retry');
    return 'Dữ liệu được lấy thành công sau khi thử lại!';
  });
}

void main() {
  // Có thể thay đổi log level để hiện debug info
  // SimpleLogger.minLevel = LogLevel.debug;

  logger.info('=== DEMO FUTURE VỚI DART ===');

  // Demo 1: Lấy dữ liệu thành công
  logger.info('1️⃣ Lấy dữ liệu từ server:');
  fetchDataFromServer()
      .then((data) {
        logger.info('✅ Thành công! Dữ liệu nhận được: $data');
        logger.info('📊 Dữ liệu đã được xử lý và hiển thị');
      })
      .catchError((error) {
        logger.error('❌ Lỗi: $error', error);
      });

  // Demo 2: Lấy nhiều dữ liệu tuần tự
  logger.info('2️⃣ Lấy nhiều loại dữ liệu:');
  fetchDataFromServer()
      .then((userData) {
        logger.info('✅ Lấy dữ liệu người dùng: $userData');
        return fetchDataFromServer(); // Lấy dữ liệu tiếp theo
      })
      .then((productData) {
        logger.info('✅ Lấy dữ liệu sản phẩm: $productData');
        logger.info('🎉 Hoàn thành tải tất cả dữ liệu!');
      })
      .catchError((error) {
        logger.error('❌ Lỗi trong quá trình lấy dữ liệu: $error', error);
      });

  // Demo 3: Xử lý lỗi
  logger.info('3️⃣ Demo xử lý lỗi kết nối:');
  fetchDataWithError()
      .then((data) {
        logger.info('✅ $data');
      })
      .catchError((error) {
        logger.warning('❌ Đã xảy ra lỗi: $error', error);
        logger.info('🔄 Có thể thử lại sau...');
      })
      .whenComplete(() {
        logger.info('🏁 Kết thúc thao tác (dù thành công hay thất bại)');
      });

  // Demo 4: Sử dụng timeout
  logger.info('4️⃣ Demo với timeout:');
  fetchDataFromServer()
      .timeout(Duration(seconds: 3))
      .then((data) {
        logger.info('✅ Lấy dữ liệu nhanh: $data');
      })
      .catchError((error) {
        if (error.toString().contains('TimeoutException')) {
          logger.warning('⏰ Timeout: Server phản hồi quá chậm');
        } else {
          logger.error('❌ Lỗi khác: $error', error);
        }
      });

  logger.info('⏳ Chương trình đang chạy... (chờ các Future hoàn thành)');

  // Giữ chương trình chạy để xem kết quả
  Future.delayed(Duration(seconds: 15), () {
    logger.info('🎯 Demo hoàn thành!');
  });
}
