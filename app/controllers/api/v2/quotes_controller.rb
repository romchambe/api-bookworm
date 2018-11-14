module Api::V2
  class QuotesController < ApplicationController

    def create 
      begin
        @quote = Quote.create!(user: @current_user)

        decoded_image = Base64.decode64(params[:upload])
        filename = params[:filename]

        @quote.upload.attach(io: StringIO.new(decoded_image, 'rb'), filename: filename)

        gcs_url = @quote.upload.service_url.split(/bookwormapp_24072018\//)[1].split(/\?/)[0]
        response = GoogleVisionAnalyzer.new(gcs_url: gcs_url).perform

        @quote.full_response = response
        unless response["responses"][0]["fullTextAnnotation"]["text"].nil? 
          @quote.relevant_text = response["responses"][0]["fullTextAnnotation"]["text"] 
        end 
        @quote.save

        render json: {url: gcs_url, response: @quote.relevant_text, quote_id: @quote.id}

      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.to_s }, status: :unprocessable_entity
      end
    end

    def update
      @quote = Quote.find(params[:quote_id])
      @quote.update(note_id: params[:note_id])
      render json: {}, status: :ok
    end
  end
end 

