class SubredditsController < ApplicationController

  def index
    render json: Subreddit.all
  end

  def show
    render json: Subreddit.find(params["subreddit"])
  end

  def create
    render json: Subreddit.create(params["subreddit"])
  end

  def update
    render json: Subreddit.update(params["id"], params["subreddit"])
  end

  def delete
    render json: Subreddit.delete(params["id"])
  end

  def followsub
    render json: Subreddit.followsub(params["sub_reddit_id"], params["user_id"])
  end




end
