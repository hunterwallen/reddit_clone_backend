class AccountsController < ApplicationController

  def index
    render json: Account.all
  end

  def show
    render json: Account.find(params["account"])
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

  def addsub
    render json: Account.addsub(params["account"])
  end

  def leavesub
    render json: Account.leavesub(params["account"])
  end

  def react
    render json: Account.react(params["account"])
  end


end
