Cam.destroy_all
Lens.destroy_all
Album.destroy_all
Photo.destroy_all

image = File.open '/Library/WebServer/Documents/photo-portfolio/tmp/image.jpg'

cam = Cam.create name: 'Canon EOS 650D'
lens = Lens.create name: 'Tokina 124 PRO DX II'

album = Album.create name: 'Spain', description: 'Album description'

(0..5).each do |i|
  photo = Photo.create name: "Photo #{i+1}", description: 'Photo description', album: album, cam: cam, lens: lens, iso: 100, aperture: 11, exposure: '1/1000', focal_distance: 34, image: image
end

album = Album.create name: 'Spain', description: 'Album description'

(0..3).each do |i|
  photo = Photo.create name: "Photo #{i+1}", description: 'Photo description', album: album, cam: cam, lens: lens, iso: 100, aperture: 11, exposure: '1/1000', focal_distance: 34, image: image
end


image.close