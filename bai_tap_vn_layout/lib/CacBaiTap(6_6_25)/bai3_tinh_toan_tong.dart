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

final SimpleLogger logger = SimpleLogger('SumCalculator');

// Hàm tính tổng bất đồng bộ từ 1 đến n
Future<int> tinhTong([int n = 1000000]) async {
  logger.info('🧮 Bắt đầu tính tổng từ 1 đến ${formatNumber(n)}');

  // Ghi lại thời gian bắt đầu
  DateTime startTime = DateTime.now();

  int sum = 0;
  int batchSize = n ~/ 10; // Chia thành 10 batch để hiển thị progress

  for (int i = 1; i <= n; i++) {
    sum += i;

    // Mỗi batch sẽ có một delay nhỏ để mô phỏng processing time
    if (i % batchSize == 0) {
      double progress = (i / n * 100);
      logger.info(
        '⏳ Đang tính... ${progress.toStringAsFixed(1)}% (${formatNumber(i)}/${formatNumber(n)})',
      );

      // Delay để mô phỏng việc tính toán nặng hoặc gọi API
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  // Tính thời gian thực hiện
  DateTime endTime = DateTime.now();
  Duration executionTime = endTime.difference(startTime);

  logger.info('✅ Hoàn thành tính tổng!');
  logger.info('📊 Kết quả: ${formatNumber(sum)}');
  logger.info('⏱️  Thời gian thực hiện: ${executionTime.inMilliseconds}ms');

  return sum;
}

// Hàm tính tổng nhanh sử dụng công thức toán học
Future<int> tinhTongNhanh([int n = 1000000]) async {
  logger.info('⚡ Tính tổng nhanh bằng công thức toán học');

  // Delay nhỏ để mô phỏng
  await Future.delayed(Duration(milliseconds: 50));

  // Công thức: Sum = n * (n + 1) / 2
  int sum = n * (n + 1) ~/ 2;

  logger.info('📐 Sử dụng công thức: n × (n + 1) ÷ 2');
  logger.info(
    '📐 ${formatNumber(n)} × ${formatNumber(n + 1)} ÷ 2 = ${formatNumber(sum)}',
  );

  return sum;
}

// Hàm tính tổng với chunks (xử lý từng phần)
Future<int> tinhTongChunks([int n = 1000000]) async {
  logger.info('🔢 Tính tổng bằng cách chia thành chunks');

  int chunkSize = 100000; // Mỗi chunk 100,000 số
  int totalSum = 0;
  int chunks = (n / chunkSize).ceil();

  for (int chunk = 0; chunk < chunks; chunk++) {
    int start = chunk * chunkSize + 1;
    int end = ((chunk + 1) * chunkSize > n) ? n : (chunk + 1) * chunkSize;

    logger.info(
      '⚙️  Xử lý chunk ${chunk + 1}/${chunks}: ${formatNumber(start)} đến ${formatNumber(end)}',
    );

    // Tính tổng cho chunk này
    int chunkSum = await tinhTongChunk(start, end);
    totalSum += chunkSum;

    logger.debug('Chunk ${chunk + 1} sum: ${formatNumber(chunkSum)}');

    // Delay để mô phỏng xử lý
    await Future.delayed(Duration(milliseconds: 200));
  }

  logger.info('🎯 Tổng tất cả chunks: ${formatNumber(totalSum)}');
  return totalSum;
}

// Hàm trợ giúp tính tổng một đoạn
Future<int> tinhTongChunk(int start, int end) async {
  // Mô phỏng thời gian xử lý
  await Future.delayed(Duration(milliseconds: 10));

  int sum = 0;
  for (int i = start; i <= end; i++) {
    sum += i;
  }
  return sum;
}

// Hàm so sánh performance của các phương pháp
Future<void> soSanhPerformance() async {
  logger.info('🏁 So sánh performance các phương pháp tính tổng');
  logger.info('=' * 60);

  int n = 1000000;

  // Phương pháp 1: Tính tuần tự
  logger.info('1️⃣ Phương pháp tuần tự:');
  DateTime start1 = DateTime.now();
  int result1 = await tinhTong(n);
  Duration time1 = DateTime.now().difference(start1);

  await Future.delayed(Duration(seconds: 1));

  // Phương pháp 2: Công thức toán học
  logger.info('2️⃣ Phương pháp công thức:');
  DateTime start2 = DateTime.now();
  int result2 = await tinhTongNhanh(n);
  Duration time2 = DateTime.now().difference(start2);

  await Future.delayed(Duration(seconds: 1));

  // Phương pháp 3: Chia chunks
  logger.info('3️⃣ Phương pháp chia chunks:');
  DateTime start3 = DateTime.now();
  int result3 = await tinhTongChunks(n);
  Duration time3 = DateTime.now().difference(start3);

  // Tổng kết
  logger.info('=' * 60);
  logger.info('📊 KẾT QUẢ SO SÁNH:');
  logger.info(
    '🔢 Tất cả phương pháp đều cho kết quả: ${formatNumber(result1)}',
  );
  logger.info('⏱️  Thời gian thực hiện:');
  logger.info('   • Tuần tự: ${time1.inMilliseconds}ms');
  logger.info('   • Công thức: ${time2.inMilliseconds}ms');
  logger.info('   • Chunks: ${time3.inMilliseconds}ms');

  // Kiểm tra kết quả có đúng không
  if (result1 == result2 && result2 == result3) {
    logger.info('✅ Tất cả phương pháp cho kết quả chính xác!');
  } else {
    logger.warning('⚠️  Có sự khác biệt trong kết quả!');
  }
}

// Hàm format số để dễ đọc
String formatNumber(int number) {
  return number.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match match) => '${match[1]},',
  );
}

// Hàm main sử dụng await
Future<void> main() async {
  // Uncomment để xem debug info
  // SimpleLogger.minLevel = LogLevel.debug;

  logger.info('=== CHƯƠNG TRÌNH TÍNH TỔNG VỚI ASYNC/AWAIT ===');

  try {
    // Demo cơ bản: Tính tổng từ 1 đến 1,000,000
    logger.info('🎯 DEMO CƠ BẢN: Tính tổng từ 1 đến 1,000,000');
    logger.info('');

    int ketQua = await tinhTong();

    logger.info('');
    logger.info('🎉 KẾT QUẢ CUỐI CÙNG: ${formatNumber(ketQua)}');
    logger.info('');

    logger.info('⏳ Chờ 3 giây trước demo tiếp theo...');
    await Future.delayed(Duration(seconds: 3));

    // Demo so sánh performance
    await soSanhPerformance();

    logger.info('');
    logger.info('🏆 Chương trình hoàn thành thành công!');
  } catch (error, stackTrace) {
    logger.error('💥 Lỗi không mong đợi', error, stackTrace);
  }
}
