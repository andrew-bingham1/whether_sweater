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