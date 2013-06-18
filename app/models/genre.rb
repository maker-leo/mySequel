class Genre < ActiveRecord::Base
  has_and_belongs_to_many :sequels

  class << self
    def with_more_than_one_film
      joins(:sequels)
      .group("genres.name")
      .having("COUNT(*) > 1")
      .order("genres.name ASC")
      .count
      .keys
    end

    def earned_more_than(total)
      joins(:sequels)
      .group("genres.name")
      .having("SUM(gross_earnings) > 5000000000")
      .sum("gross_earnings")
    end
  end
end
