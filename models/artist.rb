require('pry')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(origin)
    @id = origin['id'] if origin['id']
    @name = origin['name']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM artists;")
  end

  def delete
    SqlRunner.run("DELETE FROM artists WHERE id = #{@id};")
  end

  def update
    sql = "UPDATE artists SET name = '#{@name}' WHERE id = #{@id};"
    SqlRunner.run(sql)
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

  def self.find_by_id(id)
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    artists.find{|artist| artist['id'] = id}
  end
end