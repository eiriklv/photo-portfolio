Cam.destroy_all
Lens.destroy_all
Album.destroy_all
Photo.destroy_all

images = []
(1..5).each do |i|
  images << File.open("/Library/WebServer/Documents/photo-portfolio/tmp/images/#{i}.jpg")
end

cam = Cam.create name: 'Canon EOS 650D'
lens = Lens.create name: 'Tokina 124 PRO DX II'

album = Album.create name: 'Spain', description: 'Album description', position: 1

(0..5).each do |i|
  photo = Photo.create name: "Sunset in Toledo", description: 'Photo description', album: album, cam: cam, lens: lens, iso: 100, aperture: 11, exposure: '1/1000', focal_distance: 34, image: images[i%5]
end

album = Album.create name: 'Russia', description: 'Album description', position: 2

(0..3).each do |i|
  photo = Photo.create name: "Mysterious silence", description: 'Photo description', album: album, cam: cam, lens: lens, iso: 100, aperture: 11, exposure: '1/1000', focal_distance: 34, image: images[(i+6)%5]
end

album = Album.create name: 'Holland', description: 'Album description', position: 3


images.each do |image|
  image.close
end