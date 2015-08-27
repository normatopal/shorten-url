module Shorter

  # allowed symbols
  chars_array = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a

  # exclude some symbols
  ambiguous_chars = "B8G6I1l0OQDS5Z2"

  CHARACTERS = chars_array - ambiguous_chars.scan(/./)

  mattr_accessor :url_length, :max_length
  self.url_length = 5
  self.max_length = 10

end