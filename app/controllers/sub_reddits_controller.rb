class ActionController < ApplicationController
  def index
    render json: Sub_Reddit.all
  end

  def show
    render json: Sub_Reddit.find(params["sub_reddit"])
  end

  def create
    render json: Sub_Reddit.create(params["sub_reddit"])
  end

  def update
    render json: Sub_Reddit.update(params["id"], params["sub_reddit"])
  end

  def delete
    render json: Sub_Reddit.delete(params["id"])
  end
end