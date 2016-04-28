Introduction
============
Ambient Sound System is an application built to project media files to Chromecast devices. It is currently in development.

Requirements
============

1. Espeak - Mac: ``brew install espeak`` Linux: ``sudo apt-get install espeak``
2. Lame - Mac: ``brew install lame`` Linux: ``sudo apt-get install lame``
3. PostgreSQL (DB=ambient, USER=ambient)
4. Ruby 2.2.4
5. Ruby on Rails 4.2.6
6. Bundle ``gem install bundle``

Setup with a local server
=========================

1. Clone the repository: ``https://github.com/bennettbuchanan/ambient-sound-system-rails``
2. Change directories into the application ``cd https://github.com/bennettbuchanan/ambient-sound-system-rails``
3. Run ``bundle install`` to install the dependencies.
4. Start up a rails server: ``bundle exec rails server`` (By default, rails will run on localhost:3000.)

Use with a Chromecast Device
============================
This application is built to work with a docker image. If you already have docker installed, skip to step 3.

1. With homebrew for MAC OS: run ``brew install docker`` to install docker.
2. Install the Docker Toolbox here: https://www.docker.com/products/docker-toolbox.
3. Pull the associated docker image with ``docker pull johnserrano/castnow``
4. Run ``docker run -it --rm johnserrano/castnow castnow --address <Chromecast IP address> <path to file>`` to play the file.
