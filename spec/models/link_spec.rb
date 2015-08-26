require 'rails_helper'

describe Link do

  describe ".prepare_long_url" do

    context "with valid long url" do
      it "contains protocol" do
        link = build(:link, long_url: "api.rubyonrails.org")
        link.valid?
        expect(link.long_url).to include('http')
      end
    end

    context "with not valid long url" do
      it "not allows empty value" do
        link = build(:link, long_url: "")
        link.valid?
        expect(link.errors[:long_url]).to include('is not valid')
      end

      it "detect bad url" do
        link = build(:link, long_url: "http://api.rubyonrails.org\my_rails")
        link.valid?
        expect(link.errors[:long_url]).to include('is not valid')
      end
    end

  end

  describe ".generate_short_url" do

    it "generates url from n symbols" do
      link = build(:link)
      link.generate_short_url
      expect(link.short_url.length).to eq 5
    end

    it "generates url from n+1 symbols" do
      first_link = create(:link)
      second_link = build(:link)
      second_link.stub(:random_characters).with(5).and_return(first_link.short_url)
      second_link.stub(:random_characters).with(6).and_return('RgfyEj')
      second_link.generate_short_url
      expect(second_link.short_url.length).to eq 6
    end

    it "detect generation error" do
      link = build(:link)
      link.stub(:random_characters).and_return("")
      link.valid?
      expect(link.errors[:short_url]).to include('can not be generated')
    end

    it "returns if long url is invalid" do
      link = build(:invalid_link)
      link.generate_short_url
      expect(link.short_url.length).to eq 0
    end

  end


end

