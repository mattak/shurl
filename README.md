# Shurl

Shorten url.

## Installation

NOTE:
    This application needs mongodb.
    If you aren't install mongodb, please setup first.

you could try it on bundler.

    $ bundle install --path vendor/bundle
    $ bundle exec rackup

or you could install your system.

    $ rake build
    $ rake install
    $ rackup

## Usage

post url

    $ curl -d url="http://www.google.com" http://localhost:4006
    http://localhost:4006/Xs12

redirect url

    $ curl -L http://localhost:4006/Xs12

show url

    $ curl http://localhost:4006/s/Xs12
    http://www.google.com

recursive access

    $ curl -L `curl -d url="http://www.google.com" http://localhost:4006`

