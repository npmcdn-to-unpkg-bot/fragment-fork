class CategoryController < ApplicationController

  http_basic_authenticate_with name: "yuanchenhao",password: "",except: [:show]

  def new
    create
  end
  def create
    @board = Board.find(params[:boarding_id])
    @category = @board.categories.create()
    redirect_to boarding_path(@board)
  end

  def show

  end

  def destroy
    @board = Board.find(params[:boarding_id])
    if @board.valid?
      @category = @board.categories.find(params[:id])
      @category.destroy
      redirect_to boarding_path(@board)
    else

    end

  end

  def update
    @category = Category.find(params[:id])
    @board = @category.board
    if @category.update(params.require(:category).permit(:title))
      redirect_to boarding_path(@board)
    else
      redirect_to boarding_path(@board)
    end
  end

  def movecategory

    @boardingid = params[:boarding_id]
    @categoryid = params[:category_id]
    @directionnext = params[:directionNext]

    @category = Category.find(@categoryid)
    @category_to_swap
    @boardto = Board.find(@boardingid)
    @board_categories = @boardto.categories
    @category_index_in_categories = @boardto.categories.find_index(@category)

    if @directionnext == 'false'
        if @category_index_in_categories == 0
        else
          @category_to_swap = @board_categories[@category_index_in_categories - 1]

          @category.title,@category_to_swap.title = @category_to_swap.title,@category.title
          @category.sites,@category_to_swap.sites = @category_to_swap.sites,@category.sites

          @category.save
          @category_to_swap.save

        end
    else
        if @category_index_in_categories == @board_categories.count - 1
        else
          @category_to_swap = @board_categories[@category_index_in_categories + 1]

          @category.title,@category_to_swap.title = @category_to_swap.title,@category.title
          @category.sites,@category_to_swap.sites = @category_to_swap.sites,@category.sites

          @category.save
          @category_to_swap.save
        end
    end

    redirect_to boarding_path(params[:boarding_id])
  end

  private


end
