import 'package:flutter_test/flutter_test.dart';
import 'package:keysoc_project/view_model/music_view_model.dart';
import 'package:keysoc_project/model/apis/api_response.dart';

void main() {
  group('MusicViewModel Tests', () {
    late MusicViewModel viewModel;

    setUp(() {
      viewModel = MusicViewModel();
    });

    test('initial state should be empty', () {
      expect(viewModel.response.status, equals(Status.INITIAL));
      expect(viewModel.response.message, equals('Empty Data'));
    });

    test('resetData should return to initial state', () {
      viewModel.resetData();

      expect(viewModel.response.status, equals(Status.INITIAL));
      expect(viewModel.response.message, equals('Empty Data'));
    });

    test('fetchMusicList should update status to loading then completed',
        () async {
      expect(viewModel.response.status, equals(Status.INITIAL));

      final future = viewModel.fetchMusicList('taylor swift');

      expect(viewModel.response.status, equals(Status.LOADING));
      expect(viewModel.response.message, equals('Fetching Data'));

      await future;

      expect(viewModel.response.status, equals(Status.COMPLETED));
      expect(viewModel.response.data, isNotNull);
    });

    test('fetchMusicList with empty search should handle error', () async {
      await viewModel.fetchMusicList('');

      expect(viewModel.response.status, equals(Status.COMPLETED));
      expect(viewModel.response.data, isEmpty);
    });

    test('fetchMusicList should handle network error', () async {
      try {
        await viewModel.fetchMusicList('error_test_case');
      } catch (e) {
        expect(viewModel.response.status, equals(Status.ERROR));
        expect(viewModel.response.message, isNotEmpty);
      }
    });

    test('fetchMusicList should handle special characters', () async {
      await viewModel.fetchMusicList('taylor swift!@#');

      expect(viewModel.response.status, equals(Status.COMPLETED));
      expect(viewModel.response.data, isNotNull);
    });

    test('fetchMusicList should handle multiple calls', () async {
      final future1 = viewModel.fetchMusicList('taylor');
      expect(viewModel.response.status, equals(Status.LOADING));

      await future1;
      expect(viewModel.response.status, equals(Status.COMPLETED));

      final future2 = viewModel.fetchMusicList('swift');
      expect(viewModel.response.status, equals(Status.LOADING));

      await future2;
      expect(viewModel.response.status, equals(Status.COMPLETED));
    });
  });
}
