module LinksHelper

  RECENTLY_SHOWED = 5

  def show_short_url(url)
    #request.protocol + request.host_with_port + "/#{url}"
    Rails.application.routes.url_helpers.redirect_to_long_url(short_url: url, :host => request.host_with_port)
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
