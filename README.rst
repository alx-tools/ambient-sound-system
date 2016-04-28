Introduction
============
Ambient Sound System is an application built to project media files to Chromecast devices. It is currently in development.

Setup with a local server
=========================

1. Clone the repository: ``https://github.com/bennettbuchanan/ambient-sound-system-rails``
2. Change directories into the application ``cd https://github.com/bennettbuchanan/ambient-sound-system-rails``
3. Run ``bundle install`` to install the dependencies.
4. Start up a rails server: ``bundle exec rails server`` (By default, rails will run on localhost:3000.)

Use with a Chromecast Device
============================
This application is built to work with a docker image. If you already have docker installed, skip to step 3.

1. With Homebrew for OS X: run ``brew install docker`` to install docker.
2. Install the Docker Toolbox here: https://www.docker.com/products/docker-toolbox.
3. Pull the associated docker image with ``docker pull johnserrano/castnow``
4. Run ``docker run -it --rm johnserrano/castnow castnow --address <Chromecast IP address> <path to file>`` to play the file.
