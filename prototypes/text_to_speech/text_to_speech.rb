#!/usr/bin/env ruby
# https://github.com/dejan/espeak-ruby
# I add to manually install espeak package
require 'espeak'
include ESpeak

speech = Speech.new(ARGV[0])
speech.speak # invokes espeak
speech.save("audio_file.mp3") # invokes espeak + lame
