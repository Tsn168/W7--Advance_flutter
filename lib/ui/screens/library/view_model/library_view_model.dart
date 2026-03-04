import 'package:flutter/material.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  late List<Song> _songs;

  LibraryViewModel({required this.songRepository, required this.playerState});

  List<Song> get songs => _songs;

  void init() {
    _songs = songRepository.fetchSongs();
    playerState.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() {
    notifyListeners();
  }

  bool isPlaying(Song song) {
    return playerState.currentSong == song;
  }

  void playSong(Song song) {
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}
