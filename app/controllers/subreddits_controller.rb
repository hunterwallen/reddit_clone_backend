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
    render json: Subreddit.followsub(params["subreddit"])
  end

  def unfollowsub
    render json: Subreddit.unfollowsub(params["subreddit"])
  end

  def addpost
    render json: Subreddit.addpost(params["subreddit"])
  end

  

end
