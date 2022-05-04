class Common {
  static String winner = '';

  static int max(int a, int b) {
    return a > b ? a : b;
  }

  static int min(int a, int b) {
    return a < b ? a : b;
  }

  static String player = 'x', opponent = 'o';

  static bool isMovesLeft(List<String> _board) {
    int i;
    for (i = 0; i < 9; i++) {
      if (_board[i] == '') return true;
    }
    return false;
  }

  static int _eval(List<String> _board) {
    for (int i = 0; i < 9; i += 3) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 1] &&
          _board[i + 1] == _board[i + 2]) {
        Common.winner = _board[i];
        return (Common.winner == player) ? 10 : -10;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (_board[i] != '' &&
          _board[i] == _board[i + 3] &&
          _board[i + 3] == _board[i + 6]) {
        Common.winner = _board[i];
        return (Common.winner == player) ? 10 : -10;
      }
    }
    if (_board[0] != '' && (_board[0] == _board[4] && _board[4] == _board[8]) ||
        (_board[2] != '' && _board[2] == _board[4] && _board[4] == _board[6])) {
      Common.winner = _board[4];
      return (Common.winner == player) ? 10 : -10;
    }
    return 0;
  }

  static int minMax(List<String> _board, int depth, bool isMax) {
    int score = _eval(_board);
    //print(score);
    int best = 0, i;

    if (score == 10 || score == -10) return score;
    if (!isMovesLeft(_board)) return 0;
    if (isMax) {
      best = -1000;
      for (i = 0; i < 9; i++) {
        if (_board[i] == '') {
          _board[i] = player;
          best = max(best, minMax(_board, depth + 1, !isMax));
          _board[i] = '';
        }
      }
      return best;
    } else {
      best = 1000;
      for (i = 0; i < 9; i++) {
        if (_board[i] == '') {
          _board[i] = opponent;
          best = min(best, minMax(_board, depth + 1, !isMax));
          _board[i] = '';
        }
      }
      return best;
    }
  }
}
