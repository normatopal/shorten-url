require 'shorter'

class Link < ActiveRecord::Base

  validates_presence_of :short_url, :message => "can not be generated"
  validates_presence_of :long_url, :message => "is not valid"

  before_validation(on: :create) do
    prepare_long_url
    generate_short_url
  end

  URL_PROTOCOL_HTTP = "http://"
  REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

  def prepare_long_url
      self.long_url =
        begin
          long_url = URL_PROTOCOL_HTTP + self.long_url.strip unless self.long_url =~ REGEX_LINK_HAS_PROTOCOL
          URI.parse(long_url || self.long_url).normalize.to_s
        rescue => e
          logger.error("Link generation error! Original link: " + self.long_url + "; Error: " + e.message)
          ''
        end
  end

  def generate_short_url
    return if long_url.blank?
    (Shorter.url_length..Shorter.max_length).detect do |length|
      url = random_characters(length)
      self.short_url = url if self.class.where(short_url: url).empty?
    end
  end

  private
  def random_characters(length)
    Shorter::CHARACTERS.sample(length).join
  end

end