#/bin/bash
# Send a url (terminated by a newline) to the computer which should play the
# specified file.
PORT=1111
nc -lk $PORT | {
while read line; do
  wget $line -O filetoplay.mp3
  # osx:
  # afplay filetoplay.mp3
  # linux:
  mpg123 filetoplay.mp3
  rm filetoplay.mp3
done
}
