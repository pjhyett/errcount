class SitesController < ApplicationController
  def index
    @sites = Site.find_active
    respond_to do |wants|
      wants.html
      wants.json { render :json => @sites.to_json }
      wants.xml  { render :xml  => @sites.to_xml  }
    end
  end
  
  def show
    @site = Site.find(params[:id])
    respond_to do |wants|
      wants.html
      wants.json { render :json => @site.to_json }
      wants.xml  { render :xml  => @site.to_xml  }
    end
  end
  
  def create
    url = sanitize(params[:url])
    @site = Site.find_by_url(url)
    @site = Site.create!(:url => url) unless @site
    redirect_to site_path(@site)
  rescue
    redirect_to '/'
  end

private
  def sanitize(url)
    url.gsub(/^www\./, '').gsub(/\/$/, '')
  end
end
