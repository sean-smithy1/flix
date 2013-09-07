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

    puts date.to_s

    it "if exists to long" do
      expect(helper.format_release_date(date)).to eq("May 23, 2008")

      date=nil
      expect(helper.format_release_date(date)).to eq("No release date for this movie")
    end

  end
end
