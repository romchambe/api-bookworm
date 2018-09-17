module Api::V1
  class ScansController < ApplicationController

    def create 
      begin
        @scan = Scan.create!(user: @current_user)

        decoded_image = Base64.decode64(params[:upload])
        filename = params[:filename]

        StringIO.open(decoded_image, 'w+b') do |file|
          @scan.upload.attach(io: file, filename: filename)
        end


        gcs_url = @scan.upload.service_url.split(/bookwormapp_24072018\//)[1].split(/\?/)[0]
        response = GoogleVisionAnalyzer.new(gcs_url: gcs_url).perform

        @scan.full_response = response
        @scan.relevant_text = response["responses"][0]["fullTextAnnotation"]["text"]
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

