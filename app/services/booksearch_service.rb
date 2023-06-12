require 'faraday'

class BooksearchService
  def conn
    Faraday.new(url: "https://openlibrary.org/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_books(location,limit)
    get_url("/search.json?q=#{location}&limit=#{limit}")
  end
end