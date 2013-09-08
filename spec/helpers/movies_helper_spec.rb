require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the MoviesHelper. For example:
#
# describe MoviesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe MoviesHelper do

  describe " Formats release date" do

    date = Date.new(2008,05,23)

    it " - exists" do
      expect(helper.format_release_date(date)).to have_text("May 23, 2008")
    end

    it " - does not exist" do
      date=nil
      expect(helper.format_release_date(date)).to have_text("No release date for this movie")
    end

  end
end
