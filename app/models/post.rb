class Post
    DB = PG.connect({host: 'localhost', port: 5432, dbname: 'reddit_development'})
    #dont forget to add password and turn local host to empty string Evan
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
            INSERT INTO posts (author, title, body)
            VALUES ('#{opts["author"]}', '#{opts["title"]}', '#{opts["body"]}', )
            RETURNING id, author, title, body
            SQL
        )
        return {
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
