class SiteController < ApplicationController

  http_basic_authenticate_with name: "yuanchenhao",password: "",except: [:show]

  def new
    @site = Site.new()
  end
  def create
    @category = Category.find(params[:category_id])
    @site = @category.sites.create(params.require(:site).permit(:url, :title))
    redirect_to boarding_path(@category.board)
  end

  def show

  end

  def destroy
    @category = Category.find(params[:category_id])
    @site = Site.find(params[:site_id])
    @site.destroy
    redirect_to boarding_path(@category.board)
  end

  def movesite

    @siteid = params[:site_id]
    @boardingid = params[:boarding_id]
    @categoryid = params[:category_id]
    @directionnext = params[:directionNext]

    @site_from = Site.find(@siteid)
    @site_to
    @category = Category.find(@categoryid)
    @sites_array = @category.sites

    @site_index = @sites_array.find_index(@site_from)

    if @directionnext == 'false'
      if @site_index == 0
      else
        @site_to = @sites_array[@site_index - 1]

        @site_from.title,@site_to.title = @site_to.title,@site_from.title
        @site_from.url,@site_to.url = @site_to.url,@site_from.url

        @site_from.save
        @site_to.save

      end
    else
      if @site_index == @sites_array.count - 1
      else
        @site_to = @sites_array[@site_index + 1]

        @site_from.title,@site_to.title = @site_to.title,@site_from.title
        @site_from.url,@site_to.url = @site_to.url,@site_from.url

        @site_from.save
        @site_to.save
      end
    end


    redirect_to boarding_path(params[:boarding_id])
  end

end
