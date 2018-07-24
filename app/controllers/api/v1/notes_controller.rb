module Api::V1
  class NotesController < ApplicationController
    
    def create
      @note = Note.new(note_params)
      if note.save 
        render json: @note
      else 
        render json: @note.errors.full_messages
      end
    end



    def delete
    end

    def registration_params
      params.require(:note).permit(:title, :book, :scan)
    end
  end
end 