class Sequel < ActiveRecord::Base
  belongs_to :director
  has_and_belongs_to_many :genres

  class << self
    # Three ways of doing this, I've commented out
    # the more verbose ways just to show you what
    # ActiveRecord can do
    def total_by(director)

      # Selecting custom fields, using select and column aliasing
      # This adds the field (in this case count) to the models returned
      # The column is a string so we convert it into an integer
      #
      # select('COUNT(*) AS count').joins(:director).where("directors.name" => director).first.count.to_i

      # Using find by sql to do the whole query in SQL, this is best when doing something too complex
      # for the active record helpers
      # but it is pretty ugly and unwieldy
      #
      # find_by_sql(["SELECT COUNT(*) AS count FROM sequels INNER JOIN directors ON directors.id = sequels.director_id WHERE directors.name = ?", director]).first.count.to_i

      # The neatest way of doing it, but remember this won't work for more complex queries
      joins(:director).where("directors.name" => director).count
    end

    def total_gross
      sum('gross_earnings')
    end

    def total_gross_by_year_after(year)
      where("year > ?", year)
      .group("year")
      .sum("gross_earnings")
    end

    def total_by_genre(genre)
      joins(:genres)
      .where("genres.name" => genre)
      .count
    end

    def average_gross_for(director)
      joins(:director)
      .where("directors.name" => director)
      .average('gross_earnings')
      .to_i
    end

    def minimum_made_by(director)
      joins(:director)
      .where("directors.name" => director)
      .minimum('gross_earnings')
    end

    def maximum_gross_before(year)
      where("year < ?", year)
      .maximum('gross_earnings')
    end

    def highest_grossing_by_genre_and_director(genre, director)
      joins(:director)
      .joins(:genres)
      .where("directors.name" => director)
      .where("genres.name" => genre)
      .maximum("gross_earnings")
    end
  end
end
