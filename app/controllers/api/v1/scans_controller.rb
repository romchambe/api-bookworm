module Api::V1
  class ScansController < ApplicationController

    def create 
      begin
        @scan = Scan.create!(user_id: params[:user_id])

        decoded_data = Base64.decode64(params[:upload])
        filename = params[:filename]

        File.open("#{Rails.root}/tmp/images/#{filename}", 'wb') do |file|
          file.write(decoded_data)
        end

        @scan.upload.attach(io: File.open("#{Rails.root}/tmp/images/#{filename}"), filename: filename)
        FileUtils.rm("#{Rails.root}/tmp/images/#{filename}")

        gcs_url = @scan.upload.service_url.split(/bookwormapp_24072018\//)[1].split(/\?/)[0]
        response = GoogleVisionAnalyzer.new(gcs_url: gcs_url).perform

        @scan.full_response = response
        @scan.relevant_text = response["responses"][0]["fullTextAnnotation"]["text"]
        @scan.save

        render json: {url: gcs_url, response: @scan.relevant_text}

      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.to_s }, status: :unprocessable_entity
      end

    end
  end
end 
