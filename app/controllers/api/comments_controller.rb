class Api::CommentsController < ApplicationController
  def index
    @comments = Comment.where(app_id: params[:id])
    render 'index.json.jbuilder'
  end

  def create
    @comment = Comment.new(
      input: params[:input],
      issue_id: params[:issue_id]
      )
    if @comment.save
      render 'show.json.jbuilder'
    else
      render json:{errors: @comment.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.find(params[:id])
    if @comment
      render 'show.json.jbuilder'
    else
      render json:{message: "Comment not found."}
    end
  end

  def update
    @comment = Comment.find(params[:id])

    @comment.input = params[:input] || @comment.input    
    
    if @comment.save
      render 'show.json.jbuilder'
    else
      render json:{errors: @comments.errors.full_messages}, status: :unprocessable_entity
    end
  end
    
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json:{message: "Comment has been deleted."}
  end
end
