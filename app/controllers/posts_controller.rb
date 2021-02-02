class PostsController < ApplicationController

  def index
    render json: Post.all
  end

  def show
    render json: Post.find(params["id"])
  end

  def create
    render json: Post.create(params["post"])
  end

  def update
    render json: Post.update(params["id"], params["post"])
  end

  def delete
    render json: Post.delete(params["id"])
  end

  def create_many
    render json: Post.create_many(params["post"])
  end

  def upvote
    render json: Post.upvote(params["post"])
  end

  def downvote
    render json: Post.downvote(params["post"])
  end

end
