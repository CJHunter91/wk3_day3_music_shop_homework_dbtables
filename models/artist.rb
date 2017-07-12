require('pry')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id

def initialize(origin)
  @id = origin['id'] if origin['id']
  @name = origin['name']
end

def save
  sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;"
  @id = SqlRunner.run(sql)[0]['id'].to_i
end

def self.list_all
  sql = "SELECT * FROM artists;"
  artists = SqlRunner.run(sql)
  artists.map {|artist| Artist.new(artist)}
end

def list_albums
  sql = "SELECT * FROM albums WHERE artist_id = #{@id};"
  albums = SqlRunner.run(sql)
  return albums.map{|album| Album.new(album)}
end


end