# require 'bcrypt'
#
# class Account < ActiveRecord::Base
#     include BCrypt
#
#     if ENV["DATABASE_URL"]
#       PG.connect(ENV['DATABASE_URL'])
#     elsif
#       DB = PG.connect({:host => "localhost", :port => 5432, :dbname => 'reddit_development'})
#     end
#
#     def self.all
#         results = DB.exec("SELECT * FROM accounts;")
#         return results.each do |result|
#         {
#             "user_id" => result["user_id"].to_i,
#             "user_name" => result["user_name"],
#             "password" => result["password"],
#             "email" => result["email"],
#             "post_id" => result["post_id"],
#             "sub_reddit_id" => result["sub_reddit_id"],
#             "post_reaction_id" => result["post_reaction_id"]
#         }
#         end
#     end
#
#      def self.create(opts)
#        new_password = BCrypt::Password.create(opts["password"])
#     results = DB.exec(
#         <<-SQL
#             INSERT INTO accounts (user_name, password, email)
#             VALUES ( '#{opts["user_name"]}', '#{new_password}', '#{opts["email"]}' )
#             RETURNING user_id, user_name, email;
#         SQL
#     )
#     return {
#         "user_id" => results.first["id"].to_i,
#         "user_name" => results.first["user_name"],
#         "email" => results.first["email"]
#     }
#   end










end
