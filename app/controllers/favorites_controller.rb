class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @favorite = current_user.favorite.new(book_id: book.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    book = Book.find(params[:book_id])
    @favorite = current_user.favorite.find_by(book_id: book.id)
    @favorite.destroy
    render 'replace_btn'
  end

end
