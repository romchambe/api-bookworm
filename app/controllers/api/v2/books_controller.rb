module Api::V2
  class BooksController < ApplicationController
    before_action :find_book, only: [:update, :destroy, :book_details]

    def create  
      @book = Book.new(valid_params(:book))
      @book.user = @current_user

      if @book.save 
        errors_on_dependents = []

        if !!valid_params(:quote) && !!(quote = Quote.new(valid_params(:quote)))
          quote.book = @book 
          quote.save
          errors_on_dependents.concat(quote.errors.full_messages) unless quote.save
        end

        if !!valid_params(:comment) && !!(comment = Comment.new(valid_params(:comment)))
          comment.book = @book
          comment.quote = quote unless !(!!quote)
          errors_on_dependents.concat(comment.errors.full_messages) unless comment.save 
        end 

        render json: { 
          book: @book, 
          errors_on_dependent: !errors_on_dependents.empty?, 
          message: errors_on_dependents.empty? ? nil : errors_on_dependents 
        }
      else 
        render json: { error: true, message: @book.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      @books =  @current_user.books.includes(:quotes)
      render json: { booksList: @books.map { |book| book.with_quote_count } }
    end

    def book_details
      quotes = @book.quotes.includes(:comments)
      render json: {
        book: @book, 
        quotes: quotes.map {|quote| 
          {
            quote: quote,
            comments: quote.comments
          }
        }
      }
    end


    def update
      @book.update(valid_params(:book))
      render json: @book
    end

    def destroy
      @book.destroy
    end

    private 

    def find_book
      @book = Book.find(params[:id])
    end

    def valid_params(resource)
      permitted = { 
        book: [:title, :author], 
        quote: [:title, :content], 
        comment: [:content]
      }

      params.require(resource).permit(permitted[resource]) if params[resource].present?
    end
  end
end 