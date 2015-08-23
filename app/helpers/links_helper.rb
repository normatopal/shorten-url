module LinksHelper

  RECENTLY_SHOWED = 5

  def show_short_url(url)
    request.protocol + request.host_with_port + "/#{url}"
  end

  def show_long_url(url)
    url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def recently_shortenerd_count
    session[:recently_shortenerd].count
  end

  def recently_shortened_urls
    session[:recently_shortenerd].shift(recently_shortenerd_count - RECENTLY_SHOWED) if recently_shortenerd_count > RECENTLY_SHOWED # show last 5 links
    session[:recently_shortenerd].reverse
  end

end
