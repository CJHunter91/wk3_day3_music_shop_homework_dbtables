require('pry')
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all  
Artist.delete_all  

artist1 = Artist.new({'name' =>'Greg'})
artist1.save

album1 = Album.new({'title' => 'LALA', 'genre' => 'metal', 'artist_id' => artist1.id})
album2= Album.new({'title' => 'Godsmack', 'genre' => 'metal', 'artist_id' => artist1.id})

album1.save
album2.save


artist1.name = "Chris"
artist1.update

album1.title = "Crispy"
album1.update
Artist.list_all
Album.list_all
artist1.list_albums
artist1.delete
album1.delete
binding.pry
nil