class Subreddit < ApplicationRecord

       if(ENV['DATABASE_URL'])
    uri = URI.parse(ENV['DATABASE_URL'])
    DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  else
    DB = PG.connect(host: "", port: 5432, dbname: 'reddit_development', password: 'hello')
  end

  def self.all
    results = DB.exec("SELECT * FROM sub_reddit;")
    return results.each do |result|
        {
            "sub_reddit_id" => result["sub_reddit_id"].to_i,
            "post_id" => result["post_id"],
            "user_id" => result["user_id"],
            "public" => result["public"],
            "created_by" => result["created_by"].to_i,
        }
    end
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM sub_reddit WHERE sub_reddit_id=#{id}")
    return
            {
            "sub_reddit_id" => results.first["sub_reddit_id"].to_i,
            "post_id" => results.first["post_id"],
            "user_id" => results.first["user_id"],
            "public" => results.first["public"],
            "created_by" => results.first["created_by"].to_i,
            "name" => results.first["name"],
            "description" => results.first["description"]
        }

  end

  def self.create(opts)
    results = DB.exec(
        <<-SQL
        INSERT INTO sub_reddit(public, created_by, name, description)
        VALUES ( #{opts["public"]}, #{opts["created_by"]}, '#{opts["name"]}', '#{opts["description"]}')
        RETURNING public, created_by, name, description
        SQL
    )
    return
        {
            "sub_reddit_id" => results.first["sub_reddit_id"].to_i,
            "public" => results.first["public"],
            "created_by" => results.first["created_by"].to_i,
            "name" => results.first["name"],
            "description" => results.first["description"]
        }
  end


  def self.delete(id)
    results = DB.exec("DELETE FROM sub_reddit WHERE sub_reddit_id=#{id}")
    return {"deleted" => true}
  end


  def self.followsub(ids)
      results = DB.exec(
          <<-SQL
              UPDATE sub_reddit
              SET user_id = array_append(user_id, '#{ids["user_id"]}')
              WHERE sub_reddit_id=#{ids["sub_reddit_id"]}
          SQL
      )
      p "User added to subreddit"

  end


end
