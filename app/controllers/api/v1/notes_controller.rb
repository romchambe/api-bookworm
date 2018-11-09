module Api::V1
  class booksController < ApplicationController
    before_action :find_book, only: [:update]

    def create  
      @book = Book.new(book_params)
      @book.user = @current_user
      if @book.save 
        book_with_key = @book.render_hash_with_attribute_key
        puts book_with_key.to_json
        render json: book_with_key
      else 
        render json: { error: true, message: @book.errors.full_messages}
      end
    end

    def index
      books_with_key = @current_user.books.map { |book| 
        book.render_hash_with_attribute_key
      }
      render json: books_with_key
    end

    def update
      @book.update(book_params)
      render json: @book
    end

    def delete
    end

    private 

    def find_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:id, :title, :book, :content)
    end
  end
end 