require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('artist')



class Album
  
  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize(origin)
    @id = origin['id'] if origin['id']
    @title = origin['title']
    @genre = origin['genre']
    @artist_id = origin['artist_id']
  end

  def save
    sql = "INSERT INTO albums
      (title, genre, artist_id)
       VALUES ('#{@title}', '#{@genre}', #{@artist_id}) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE albums SET (
    title, 
    genre, 
    artist_id
    ) = (
    '#{@title}',
    '#{@genre}',
     #{@artist_id}
     ) WHERE
     id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM albums;")
  end

  def delete
    SqlRunner.run("DELETE FROM albums WHERE id = #{@id};")
  end

  def self.list_all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    albums.map {|album| Album.new(album)}
  end



end