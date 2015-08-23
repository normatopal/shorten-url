class Link < ActiveRecord::Base
  require Rails.root.join('lib', 'shorter')

  validates_presence_of :short_url, :message => "can not be generated"

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
        rescue
          errors.add(:base, 'Your url is not valid')
          self.long_url
        end
  end

  def generate_short_url
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