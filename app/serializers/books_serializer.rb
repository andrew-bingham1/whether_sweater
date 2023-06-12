class BooksSerializer
  include JSONAPI::Serializer

  attributes :destination do |object|
    object.book_data[:q]
  end

  attributes :forecast do |object|
    {
      summary: object.forecast_data.data[:current][:condition][:text],
      temperature: object.forecast_data.data[:current][:temp_f].to_s + " F"
    }
  end

  attributes :total_books_found do |object|
    object.book_data[:numFound]
  end

  attributes :books do |object|
    object.book_data[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end
end



# {
#   "data": {
#     "id": "null",
#     "type": "books",
#     "attributes": {
#       "destination": "denver,co",
#       "forecast": {
#         "summary": "Cloudy with a chance of meatballs",
#         "temperature": "83 F"
#       },
#       "total_books_found": 172,
#       "books": [
#         {
#           "isbn": [
#             "0762507845",
#             "9780762507849"
#           ],
#           "title": "Denver, Co",
#           "publisher": [
#             "Universal Map Enterprises"
#           ]
#         },
#         {
#           "isbn": [
#             "9780883183663",
#             "0883183668"
#           ],
#           "title": "Photovoltaic safety, Denver, CO, 1988",
#           "publisher": [
#             "American Institute of Physics"
#           ]
#         },
#         { ... same format for books 3, 4 and 5 ... }
#       ]
#     }
#   }
# }