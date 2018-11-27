module Api::V2
  class QuotesController < ApplicationController
    before_action :find_quote, only: [:update]
    def create 
      @quote = Quote.new(quote_params)
      if @quote.save
        render json: {quote: @quote}
      else
        render json: { error: true, message: @quote.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      @quote.update(quote_params)
      render json: @quote
    end

    private

    def quote_params
      params.require(:quote).permit(:id, :content, :title, :book_id)
    end

    def find_quote
      @quote = Quote.find(quote_params[:id])
    end
  end
end 

