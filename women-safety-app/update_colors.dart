import 'dart:io';

void main() {
  var files = [
    'frontend/lib/features/home/views/home_screen.dart',
    'frontend/lib/features/profile/views/profile_screen.dart',
    'frontend/lib/features/community/views/community_screen.dart',
    'frontend/lib/core/widgets/main_navigation.dart',
  ];

  for(var path in files) {
    var file = File(path);
    if (!file.existsSync()) {
      print('File not found: $path');
      continue;
    }
    var content = file.readAsStringSync();
    
    content = content.replaceAll('color: Colors.white,', 'color: Colors.black,');
    content = content.replaceAll('color: Colors.white)', 'color: Colors.black)');
    content = content.replaceAll('color: Colors.white70,', 'color: Colors.black87,');
    content = content.replaceAll('color: Colors.white70)', 'color: Colors.black87)');
    content = content.replaceAll('color: Colors.white54,', 'color: Colors.black54,');
    content = content.replaceAll('color: Colors.white54)', 'color: Colors.black54)');
    content = content.replaceAll('color: Colors.white60,', 'color: Colors.black54,');
    content = content.replaceAll('color: Colors.white60)', 'color: Colors.black54)');
    content = content.replaceAll('color: Colors.white.withOpacity(0.8)', 'color: Colors.black87');
    content = content.replaceAll('color: Colors.white.withOpacity(0.9)', 'color: Colors.black');
    content = content.replaceAll('color: Colors.white.withOpacity(0.7)', 'color: Colors.black87');
    content = content.replaceAll('color: Colors.white.withOpacity(0.6)', 'color: Colors.black54');
    
    file.writeAsStringSync(content);
    print('Updated $path');
  }
}
