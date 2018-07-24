module Api::V1
  class NotesController < ApplicationController
    before_action :find_note, only: [:update]

    def create  
      @note = Note.new(note_params)
      if @note.save 
        @note.images.attach(params[:images])
        render json: @note
      else 
        render json: @note.errors.full_messages
      end
    end

    def update
    end


    def delete
    end

    private 

    def find_note
      @note = Note.find(params[:id])
    end

    def registration_params
      params.require(:note).permit(:id, :title, :book, :images)
    end
  end
end 