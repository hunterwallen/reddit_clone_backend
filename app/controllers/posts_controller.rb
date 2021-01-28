class PostsController < ApplicationController

  def index
    render json: Post.all
  end

  def show
    render json: Post.find(params["id"])
  end

  def create
    render json: Post.create(params["person"])
  end

  def update
    render json: Post.update(params["id"], params["post"])
  end

  def delete
    render json: Post.delete(params["id"])
  end
end



# def self.find(id)
#   result = DB.exec("SELECT * FROM posts WHERE id={#{id}};")
#   return {
#     "id" => results.first["id"].to_i,
#     "title" => results.first["title"],
#     "user" => results.first["user"],
#     "body" => results.first["body"]
#   }
# end
#
# def self.create(opts)
#   results = DB.exec(
#     <<-SQL
#       INSERT INTO posts (user, title, body)
#       VALUES ( '#{opts["user"]}', '#{opts["title"]}', '#{opts["body"]}')
#       RETURNING user, title, body;
#       SQL
#   )
#   return {
#     "id" => results.first["id"].to_i,
#     "title" => results.first["title"],
#     "user" => results.first["user"],
#     "body" => results.first["body"]
#   }
# end
