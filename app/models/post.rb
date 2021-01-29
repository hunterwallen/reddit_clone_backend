class Post < ApplicationRecord

    if ENV["DATABASE_URL"]
      PG.connect(ENV['DATABASE_URL'])
    elsif
      DB = PG.connect({:host => "", :port => 5432, :dbname => 'reddit_development', password: 'hello'})
    end


    def self.all
      results = DB.exec("SELECT * FROM posts;")
      return results.each do |result|
          {
              "id" => result["id"].to_i,
              "author" => result["author"],
              "title" => result["title"],
              "body" => result["body"]
          }
      end
    end

    def self.find(id)
        results = DB.exec("SELECT * FROM posts WHERE id=#{id};")
        return
        {
            "id" => results.first["id"].to_i,
            "author" => results.first["author"],
            "title" => results.first["title"],
            "body" => results.first["body"]
        }
    end

    def self.create(opts)
        results = DB.exec(
            <<-SQL
            INSERT INTO posts(author, title, body)
            VALUES ('#{opts[:author]}', '#{opts[:title]}', '#{opts[:body]}')
            RETURNING *;
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "author" => results.first["author"],
            "title" => results.first["title"],
            "body" => results.first["body"]
        }
    end



    def self.create_many(seed)
      results = []
      p results
      p seed
      seed.map do |this_seed|
        p this_seed
        p this_seed[:author]
          results.push(DB.exec(
          <<-SQL
          INSERT INTO posts(author, title, body)
          VALUES ('#{this_seed[:author]}', '#{this_seed[:title]}', '#{this_seed[:body]}')
          RETURNING id, author, title, body;
          SQL
        )
      )
      p results
      end
      return{
          "id" => results.first["id"].to_i,
          "author" => results.first["author"],
          "title" => results.first["title"],
          "body" => results.first["body"]
      }

    end

    def self.delete(id)
        results = DB.exec("DELETE FROM posts WHERE id=#{id}")
        return {"deleted" => true}
    end

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