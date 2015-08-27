class LinksController < ApplicationController
  before_filter Proc.new { session[:recently_shortenerd] ||= [] }, only: [:new, :create, :redirect_to_url]

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      session[:recently_shortenerd].push(@link)
      # show only last 5 links
      session[:recently_shortenerd].shift(session[:recently_shortenerd].count - LinksHelper::RECENTLY_SHOWED) if session[:recently_shortenerd].count > LinksHelper::RECENTLY_SHOWED
      redirect_to shorten_path(@link.short_url)
    else
      render "new"
    end
  end

  def shorten
    @link = Link.find_by_short_url(params[:short_url])
    if @link
      @new_link = Link.new
    else
      redirect_to root_path
    end
  end

  def redirect_to_url
    link = Link.find_by_short_url(params[:short_url])
    if link.present? && link.long_url.present?
       Link.increment_counter(:clicks_count, link.id)
       recently_link = session[:recently_shortenerd].detect{|lnk| lnk['short_url'] == link.short_url}
       recently_link['clicks_count'] = link.reload.clicks_count if recently_link.present?
       redirect_to link.long_url
    else
       redirect_to root_path
    end

  end

  # Strong Parameters in rails ~> 4
  private

  def link_params
    params.require(:link).permit(:short_url, :long_url)
  end

end
