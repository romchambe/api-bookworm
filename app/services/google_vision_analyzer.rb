require 'rest-client'

class GoogleVisionAnalyzer
  def initialize(params)
    @gcs_url = params[:gcs_url]
    @key = Rails.application.credentials.vision
  end

  def perform
    begin 
      @response = RestClient.post "https://vision.googleapis.com/v1/images:annotate?key=#{@key}", {
        requests:[
          {image:
            {source:
              {
                imageUri:"gs://bookwormapp_24072018/#{@gcs_url}"
              }
            },
            features:[
              {type:"DOCUMENT_TEXT_DETECTION"}
            ]
          }
        ]
      }.to_json, {content_type: :json}

      @text = JSON.parse(@response.body)

      return @text
    rescue RestClient::ExceptionWithResponse => e
      e.response 
    end 

    
  end
end 