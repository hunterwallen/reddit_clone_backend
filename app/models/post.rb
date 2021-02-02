class Post < ApplicationRecord

  if(ENV['DATABASE_URL'])
    uri = URI.parse(ENV['DATABASE_URL'])
    DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  else
    DB = PG.connect(host: "localhost", port: 5432, dbname: 'reddit_development')
  end


    def self.all
      results = DB.exec("SELECT * FROM posts;")
      return results.each do |result|
          {
              "id" => result["id"].to_i,
              "author" => result["author"],
              "title" => result["title"],
              "body" => result["body"],
              "img_url" => result["img_url"]
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
            "body" => results.first["body"],
            "img_url" => results.first["img_url"]
        }
    end

    def self.create(opts)
        results = DB.exec(
            <<-SQL
            INSERT INTO posts(author, title, body, user_id, subreddit_id, img_url)
            VALUES ('#{opts[:author]}', '#{opts[:title]}', '#{opts[:body]}', #{opts[:user_id]}, #{opts[:subreddit_id]}, '#{opts[:img_url]}')
            RETURNING *;
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "author" => results.first["author"],
            "title" => results.first["title"],
            "body" => results.first["body"],
            "user_id" => results.first["body"],
            "subreddit_id" => results.first["subreddit_id"].to_i,
            "img_url" => results.first["img_url"]
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

    def self.upvote(post_id)
      results = DB.exec(
          <<-SQL
              UPDATE posts
              SET votes = votes + 1
              WHERE id=#{post_id}
          SQL
      )
      p "Post voted up by user"

    end

    def self.downvote(post_id)
      results = DB.exec(
          <<-SQL
              UPDATE posts
              SET votes = votes - 1
              WHERE id=#{post_id}
          SQL
      )
      p "Post voted down by user"

    end

end
