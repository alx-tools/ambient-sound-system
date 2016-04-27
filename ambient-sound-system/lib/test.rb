require 'espeak'
include ESpeak

@speech = Speech.new("This is what is to be said.")
@speech.speak # invokes espeak
@speech.save("audio_file.mp3") # invokes espeak + lame
