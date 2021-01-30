class AccountsController < ApplicationController

  def index
    render json: Account.all
  end

  def show
    render json: Account.find(params["id"])
  end

  def create
    render json: Account.create(params["account"])
  end

  def update
    render json: Account.update(params["id"], params["account"])
  end

  def delete
    render json: Account.delete(params["id"])
  end

end