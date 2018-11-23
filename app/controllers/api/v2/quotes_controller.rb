module Api::V2
  class QuotesController < ApplicationController
    before_action :find_quote, only: [:update]
    def create 
    end

    def update
      @quote.update(quote_params)
      render json: @quote
    end

    private

    def quote_params
      params.require(:quote).permit(:id, :content, :title)
    end

    def find_quote
      @quote = Quote.find(quote_params[:id])
    end
  end
end 

