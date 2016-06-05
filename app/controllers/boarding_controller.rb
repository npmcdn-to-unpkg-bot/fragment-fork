class BoardingController < ApplicationController

  http_basic_authenticate_with name: "yuanchenhao",password: "",only: [:new,:create]

  def index
    redirect_to boarding_path(:id=>1)
  end

  def new
    @newboard = Board.new()
    create
  end

  def create
    @newboard = Board.new()

    @newcategory = Category.new()
    @newboard.categories.push(@newcategory)

    if @newboard.save
      redirect_to action: "show", id: @newboard[:id]
    else
      redirect_to root_path
    end
  end

  def show
    @boardindex = params[:id].to_i
    if @boardindex == 0
      @boardindex = 1
    end
    @board = Board.find(@boardindex)
    @boardtotalnum = Board.count

    @site = Site.new()

  end

  def search

    @search_word = params[:q]

    @boardindex = params[:boarding_id].to_i

    @results = Array.new
    @board = Board.find(@boardindex)
    @board.categories.each do |category|
        category.sites.each do |site|
          if (site.title.include? @search_word) || (site.url.include? @search_word)
            @results.push(site)
          end
        end
    end

    @googletext = ',"action": {"url": "https://www.google.com/#q='+@search_word + '"'+ ', "text": "搜索 '+@search_word + '"'+ '}'

    @resultjson = '{"success": true,"results":'+ @results.to_json(:except => [:category_id,:created_at,:updated_at,:id]) + @googletext + '}'

    render plain: @resultjson

    # render :json => @results,content_type: 'application/json'
    # render :json => @board,content_type: 'application/json', :include => [:categories => { :include => [:sites => {}] }],:except => [:title,:created_at,:updated_at,:id]
    # render json: @board ,content_type: 'application/json'
  end

  # def newcategory (boardindex)
  #   @board = Board.find(boardindex)
  #   @newcategory = Category.new()
  #   @board.categories.push(@newcategory)
  # end

  # def seteditingsite
  #   @site = Category.find(params[:categoryindex]).sites.new()
  # end
  # helper_method :seteditingsite

  private

end
