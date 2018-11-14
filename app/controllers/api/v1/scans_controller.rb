module Api::V1
  class ScansController < ApplicationController

    def create 
      begin
        @scan = Scan.create!(user: @current_user)

        decoded_image = Base64.decode64(params[:upload])
        filename = params[:filename]

        @scan.upload.attach(io: StringIO.new(decoded_image, 'rb'), filename: filename)

        gcs_url = @scan.upload.service_url.split(/bookwormapp_24072018\//)[1].split(/\?/)[0]
        response = GoogleVisionAnalyzer.new(gcs_url: gcs_url).perform

        @scan.full_response = response
        unless response["responses"][0]["fullTextAnnotation"]["text"].nil? 
          @scan.relevant_text = response["responses"][0]["fullTextAnnotation"]["text"] 
        end 
        @scan.save

        render json: {url: gcs_url, response: @scan.relevant_text, scan_id: @scan.id}

      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.to_s }, status: :unprocessable_entity
      end
    end

    def update
      @scan = Scan.find(params[:scan_id])
      @scan.update(note_id: params[:note_id])
      render json: {}, status: :ok
    end
  end
end
