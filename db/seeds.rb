# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# require 'faker'
# Movie.destroy_all
# puts 'Creating 5 fake movies...'
# 5.times do
#   movie = Movie.new(
#     title: Faker::Movie.title,
#     overview: Faker::Lorem.paragraph(sentence_count: 5),
#     poster_url: Faker::Internet.url,
#     rating: Faker::Number.decimal(l_digits: 1)
#   )
#   movie.save!
# end
# puts 'Finished!'

require 'json'
require 'open-uri'

# puts 'Destroying all movies...'
# Movie.destroy_all
puts 'Done!'
url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_api_content = URI.open(url).read
movies = JSON.parse(movies_api_content)
puts 'Creating movies from the API...'
movies["results"].each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end
puts 'All done !'
