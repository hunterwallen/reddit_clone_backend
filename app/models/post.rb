class Post < ApplicationRecord

      if ENV["DATABASE_URL"]
    PG.connect(ENV['DATABASE_URL'])
    elsif
    DB = PG.connect({:host => "", :port => 5432, :dbname => 'reddit_development', password: 'hello'})
    end

    def self.delete(id)
        results = DB.exec("DELETE FROM posts WHERE id=#{id}")
        return {"deleted" => true}
    end
    #
    def self.update(id, opts)
        results = DB.exec(
            <<-SQL
                UPDATE posts
                SET author='#{opts["author"]}', title='#{opts["title"]}', body='#{opts["body"]}'
                WHERE id=#{id}
                RETURNING id, author, title, body;
            SQL
        )
        return{
            "id" => results.first["id"].to_i,
            "author" => results.first["author"],
            "title" => results.first["title"],
            "body" => results.first["body"]
        }

    end

end