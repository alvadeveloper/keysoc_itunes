// test/network/music_api_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:keysoc_project/model/music.dart';

void main() {
  group('Music Model Tests', () {
    test('should sort by collectionName first, then trackName', () {
      // 準備測試數據
      List<Music> testList = [
        Music(trackName: 'C Song', collectionName: 'B Album'),
        Music(trackName: 'A Song', collectionName: 'C Album'),
        Music(trackName: 'B Song', collectionName: 'A Album'),
        Music(trackName: 'D Song', collectionName: 'A Album'),
      ];

      // 執行排序
      testList.sort((a, b) {
        String collectionNameA = (a.collectionName ?? '').toLowerCase();
        String collectionNameB = (b.collectionName ?? '').toLowerCase();

        int collectionComparison = collectionNameA.compareTo(collectionNameB);

        if (collectionComparison == 0) {
          String trackNameA = (a.trackName ?? '').toLowerCase();
          String trackNameB = (b.trackName ?? '').toLowerCase();
          return trackNameA.compareTo(trackNameB);
        }

        return collectionComparison;
      });

      // 驗證結果
      expect(testList[0].collectionName, 'A Album');
      expect(testList[0].trackName, 'B Song');

      expect(testList[1].collectionName, 'A Album');
      expect(testList[1].trackName, 'D Song');

      expect(testList[2].collectionName, 'B Album');
      expect(testList[3].collectionName, 'C Album');
    });
  });
}
