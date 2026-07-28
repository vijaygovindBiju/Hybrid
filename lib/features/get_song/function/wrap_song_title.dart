String wrapSongTitle(String title) {
  if (title.length >= 20) {
    return "${title.substring(0, 15)}...";
  }
  return title;
}
