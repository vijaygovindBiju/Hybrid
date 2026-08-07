String wrapSongTitle(String title) {
  if (title.length >= 24) {
    return "${title.substring(0, 20)}...";
  }
  return title;
}
