require "shurl/version"
require 'mongo'
require 'logger'

##
# Shurl
#   manage url and it's code.
#
#   column definition:
#     { url: longurl, code: hash_code }
#
module Shurl
  class Model
    # mongo db setup
    def initialize()
      connect = Mongo::Connection.new
      db      = connect.db("shurl")
      @coll   = db.collection("urls")
      @log    = Logger.new(STDERR)
    end

    def strand(n)
      char = (("a".."z").to_a + (0..9).to_a)
      n.times.collect { |i| char.shuffle[0].to_s }.join
    end

    def to_shorturl(request, code)
      if request.port == 80
        request.scheme.to_s + "://" \
          + request.host.to_s + "/" \
          + code.to_s
      else
        request.scheme.to_s + "://" \
          + request.host.to_s + ":" + request.port.to_s + "/" \
          + code.to_s
      end
    end

    def to_longurl(code)
      doc = @coll.find_one({code: code})
      doc["url"] if doc != nil
    end

    def find_or_create_url(request, longurl)
      doc = @coll.find_one({url: longurl})

      # create
      if doc == nil 
        code = strand(4)
        doc = { "url" => longurl, "code" => code }
        @coll.insert(doc)
      end

      to_shorturl(request, doc["code"])
    end
  end
end
