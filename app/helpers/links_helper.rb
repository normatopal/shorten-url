module LinksHelper

  RECENTLY_SHOWED = 5

  def show_short_url(url)
    redirect_to_long_url(short_url: url)
  end

  def show_long_url(url)
    url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end

  def recently_shortenerd_count
    session[:recently_shortenerd].count
  end

  def recently_shortened_urls
    session[:recently_shortenerd].reverse
  end

end
