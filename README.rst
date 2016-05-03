Introduction
============
Ambient Sound System is an application built to project media files to Chromecast devices. It is currently in development.

Requirements
============

* Node - Mac: ``brew node`` Linux: ``sudo apt-get install node``.
* Espeak and Lame - Mac: ``brew install espeak lame`` Linux: ``sudo apt-get install espeak lame``.
* PostgreSQL (DB=ambient, USER=ambient). In the psql terminal run ``CREATE USER ambient;`` to create the user and then run ``GRANT ALL PRIVILEGES ON DATABASE ambient to ambient;`` to add correct privileges.
* Ruby 2.3 (If you need to update Ruby, we recommend this tutorial: https://www.brightbox.com/blog/2016/01/06/ruby-2-3-ubuntu-packages/).
* Ruby on Rails 4.2.6 by running ``sudo gem install rails -v 4.2.6``.
* Bundle ``sudo gem install bundle``.
* Install castnow globally ``sudo npm install castnow -g``.

Setup with a local server
=========================

1. Clone the repository: ``https://github.com/bennettbuchanan/ambient-sound-system-rails``.
2. Change directories into the application ``cd https://github.com/bennettbuchanan/ambient-sound-system-rails``.
3. Run ``bundle install`` to install the dependencies.
4. Start up a rails server: ``bundle exec rails server``. (By default, rails will run on localhost:3000.)
