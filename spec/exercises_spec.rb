require 'spec_helper'

# In these exercises, follow the pattern done in the example exercise
# where you create a method in the relevant model
# and pass in any arguments relevant to the current exercise
# all SQL queries generated by this test are printed to log for your convenience
#
# To make them pass don't forget to do `rake db:test:prepare` before starting zeus
# or running any tests, this will add fixtures to your test database
#
# If you want to test out SQL commands in your development db (remember rails console/dbconsole only works with the dev DB)
# you need to do `rake db:fixtures:load`

describe 'SQL Exercises' do

  context 'examples' do
    it "selects the total movies made by Spielberg" do
      Sequel.total_by('Steven Spielberg').should eq 3
    end

    it "selects the total movies made by Jackson" do
      Sequel.total_by('Peter Jackson').should eq 2
    end
  end

  # This is the reference to the API documentation for all the SUM functions
  # although see if you can do them yourself as well just using find_by_sql
  # or you won't get a proper understanding of what the underlying SQL
  # http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html
  context 'SUM' do
    it 'selects the sum gross of all films' do
      Sequel.total_gross.should eq 7653531787
    end
  end

  context 'GROUP BY' do

    let(:sequel_grosses_after_2009) { {2010 => 1301543898, 2011 =>1424883021, 2013=>1079820220} }

    it "selects total grosses for sequels made by year after 2009" do
      # Hint you'll need to order by year to get the result to match up
      Sequel.total_gross_by_year_after(2009).should eq sequel_grosses_after_2009
    end
  end

  context 'COUNT' do
    it "counts the number of action films" do
      Sequel.total_by_genre("Action").should eq 10
    end

    it "counts the number of fantasy films" do
      Sequel.total_by_genre("Fantasy").should eq 7
    end
  end

  context "AVG" do
    it "works out the average made for a Spielberg sequel" do
      # Convert this to an integer just to make things easier
      Sequel.average_gross_for("Steven Spielberg").should eq 237351063
    end
  end

  context 'MIN' do
    it "works out the minimum made by Peter Jackson" do
      Sequel.minimum_made_by("Peter Jackson").should eq 926047111
    end
  end

  context 'MAX' do
    it "works out the maximum made by a film before 2000" do
      Sequel.maximum_gross_before(2000).should eq 197870271
    end
  end

  context 'harder exercises' do

    it "finds the most earned by an action movie directed by Spielberg" do
      # This one is actually quite easy if you use the joins() method to help you
      Sequel.highest_grossing_by_genre_and_director("Action", "Steven Spielberg").should eq 317011114
    end

    it "finds genres with more than one film attached to them" do
      # Make this return just an array with the tag names
      # This one is hard but easier if you just use find_by_sql() and then map() on the result
      # you'll need to do two joins and use HAVING
      # and also you'll need to order by name
      # so they come back in the same order
      Genre.with_more_than_one_film.should eq ["Action", "Adventure", "Comedy", "Fantasy"]
    end

    let(:expected_genres) { {"Action"=>"6209348657", "Adventure"=>"7653531787", "Fantasy"=>"5835575462"} }

    it "finds tags that have earned more than 5 billion" do
      # If you use the built in sum() method it should come back like this if you're grouping them properly
      Genre.earned_more_than(5000000000).should eq expected_genres
    end
  end

  # This is just to get your queries appearing in the Rails log
  before(:each) do
    @logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  after(:each) do
    ActiveRecord::Base.logger = @logger
  end

  def pending
    super("Exercise needs completing")
  end
end