module Api::V2
  class CommentsController < ApplicationController
    before_action :find_comment, only: [:update]
    def create 
      @comment = comment.new(comment_params)
      if @comment.save
        render json: {comment: @comment}
      else
        render json: { error: true, message: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      @comment.update(comment_params)
      render json: @comment
    end

    private

    def comment_params
      params.require(:comment).permit(:id, :content)
    end

    def find_comment
      @comment = Comment.find(comment_params[:id])
    end
  end
end