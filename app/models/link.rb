require 'common/shorter'

# link class
class Link < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :short_url,
                        message: 'can not be generated',
                        if: proc { |l| l.long_url.present? }
  validates :long_url, presence: true

  before_validation(on: :create) do
    if long_url.present?
      prepare_long_url
      generate_short_url
    end
  end

  URL_PROTOCOL_HTTP = 'http://'

  def prepare_long_url
      begin
        url = long_url
        url.insert(0, URL_PROTOCOL_HTTP) if URI(url).scheme.blank?
        errors.add(:long_url, 'is not valid') unless URI(url).is_a?(URI::HTTP)
        self.long_url = url
      rescue => e
        logger.error('Link generation error! Original link: ' +
              + long_url + '; Error: ' + e.message)
        errors.add(:long_url, e.message)
      end
  end

  def generate_short_url
    length = Shorter.url_length
    while length <= Shorter.max_length && short_url.blank?
      url_arr = []
      Shorter.random_attempts.times { url_arr << random_characters(length) }
      url_arr.detect { |url| self.short_url = url if self.class.where(short_url: url).empty? }
      length += 1
    end
  end

  private

  def random_characters(length)
    # shuffle array and choose n elements
    Shorter::CHARACTERS.sample(length).join
  end

end