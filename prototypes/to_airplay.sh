#!/bin/bash
# require aitstream gem https://github.com/unused/airstream
# airplay gem looks better but had a bug with a dependency https://github.com/elcuervo/airplay
airstream "$1" -o "$2"
