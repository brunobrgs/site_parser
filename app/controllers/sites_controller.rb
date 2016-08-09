class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def create
    @site = Site.new(site_params)

    if @site.save
      ExtractContent.perform_async(@site.id)
      render json: @site, status: :created
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  private

  def site_params
    params.permit(:url)
  end
end
