class Account < ActiveRecord::Base

    DB = PG.connect({host: '', port: 5432, dbname: 'reddit_development', password: 'hello'})

    def self.all
        results = DB.exec("SELECT * FROM accounts;")
        return results.each do |result|
        {
            "user_id" => result["user_id"].to_i,
            "user_name" => result["user_name"],
            "password" => result["password"],
            "email" => result["email"],
            "post_id" => result["post_id"],
            "sub_reddit_id" => result["sub_reddit_id"],
            "post_reaction_id" => result["post_reaction_id"]
        }
        end
    end

     def self.create(opts)
    results = DB.exec(
        <<-SQL
            INSERT INTO accounts (user_name, password, email)
            VALUES ( '#{opts["user_name"]}', '#{opts["password"]}', '#{opts["email"]}' )
            RETURNING user_id, user_name, password, email;
        SQL
    )
    return {
        "user_id" => results.first["id"].to_i,
        "user_name" => results.first["user_name"],
        "password" => results.first["password"],
        "email" => results.first["email"]
    }
  end










end
