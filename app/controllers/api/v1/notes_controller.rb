module Api::V1
  class NotesController < ApplicationController
    before_action :find_note, only: [:update]

    def create  
      @note = Note.new(note_params)
      @note.user = @current_user
      if @note.save 
        note_with_key = @note.render_hash_with_attribute_key
        puts note_with_key
        render json: note_with_key
      else 
        render json: @note.errors.full_messages
      end
    end

    def index
      notes_with_key = @current_user.notes.map { |note| 
        note.render_hash_with_attribute_key
      }
      render json: notes_with_key
    end

    def update
      @note.update(note_params)
      render json: @note
    end

    def delete
    end

    private 

    def find_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:id, :title, :book, :content)
    end
  end
end 