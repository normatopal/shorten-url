module LinksHelper

  RECENTLY_SHOWED = 5

  def show_short_url(url)
    #redirect_to_long_url(short_url: url)
    "#{request.host_with_port}/#{url}"
  end

  def show_long_url(url)
    url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def recently_shortened_count
    @recently_shortened.count
  end

  def recently_shortened_urls
    @recently_shortened.reverse
  end

end
