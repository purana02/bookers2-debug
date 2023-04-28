class BooksController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_currect_user, only: [:update,:edit]

  def show
    @book = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
    @user = @book.user
    @booknew = Book.new
    @book_comment = BookComment.new
    @book_tags=@book.tags
  end

  def index
    @books = Book.all.order(params[:sort])
    #to  = Time.current.at_end_of_day
    #from  = (to - 6.day).at_beginning_of_day
    #@books = Book.all.sort {|a,b|

        #b.favorites.where(created_at: from...to).size <=>
        #a.favorites.where(created_at: from...to).size
      #}
    @book = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @tag_list=params[:book][:name].split(',')
    if @book.save
       @book.save_tag(@tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id, :rate)
  end

  def ensure_currect_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def sort_params
    params.permit(:sort)
  end

end
