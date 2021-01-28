class Post 
    DB = PG.connect({host: '', port: 5432, dbname: 'reddit_development', password: 'hello'})
    
    def self.all
        results = DB.exec("SELECT * FROM posts;")
        return results.each do |result|
            {
                "id" => result["id"].to_i,
                "title" => result["title"],
                "body" => result["body"],
                "user" => result["user"]
            }
        end
    end

    def self.find(id)
        results = DB.exec("SELECT * FROM posts WHERE id=#{id};")
        return 
        { 
            "id" => results.first["id"].to_i,
            "title" => results.first["title"],
            "body" => results.first["body"],
            "user" => results.first["user"]
        }
    end

    def self.create(opts)
        results = DB.exec(
            <<-SQL
                    INSERT INTO posts (title, body, user)
                    VALUES ('#{opts["title"]}', '#{opts["body"]', '#{opts["user"]')
                    RETURNING id, title, body, user
            SQL
        )
        
    end

end