require 'bcrypt'

class Account < ActiveRecord::Base
    include BCrypt

    if(ENV['DATABASE_URL'])
      uri = URI.parse(ENV['DATABASE_URL'])
      DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
      DB = PG.connect(host: "localhost", port: 5432, dbname: 'reddit_development')
    end

    def self.all
        results = DB.exec("SELECT * FROM accounts;")
        return results.each do |result|
        {
            "user_id" => result["id"].to_i,
            "user_name" => result["user_name"],
            "email" => result["email"],
            "post_id" => result["post_id"],
            "sub_reddit_id" => result["sub_reddit_id"],
            "post_reaction_id" => result["post_reaction_id"]
        }
        end
    end


    def self.find(login_details)
      this_email = login_details["email"]
        results = DB.exec("SELECT * FROM accounts WHERE email LIKE '#{this_email}';")
        pass = BCrypt::Password.new(results.first["password"])
        input_pass = "#{login_details["password"]}"
        p pass == input_pass
        if pass == input_pass
          {"user_id" => results.first["user_id"].to_i,
            "username" => results.first["user_name"],
            "post_id" => results.first["post_id"],
            "sub_reddit_id" => results.first["sub_reddit_id"],
            "post_reaction_id" => results.first["post_reaction_id"]
            }
          else
            p "no pass"
            {}
          end
    end


     def self.create(opts)
       new_password = BCrypt::Password.create(opts["password"])
    results = DB.exec(
        <<-SQL
            INSERT INTO accounts (user_name, password, email)
            VALUES ( '#{opts["user_name"]}', '#{new_password}', '#{opts["email"]}' )
            RETURNING user_id, user_name, email;
        SQL
    )
    return {
        "user_id" => results.first["id"].to_i,
        "user_name" => results.first["user_name"],
        "email" => results.first["email"]
    }
  end

  def self.addsub(account)
      results = DB.exec(
          <<-SQL
              UPDATE accounts
              SET sub_reddit_id = array_append(sub_reddit_id, '#{account["sub_reddit_id"]}')
              WHERE user_id=#{account["user_id"]}
          SQL
      )
      p "Subreddit added to user"

  end

  def self.leavesub(account)
    results = DB.exec(
        <<-SQL
            UPDATE accounts
            SET sub_reddit_id = array_remove(sub_reddit_id, '#{account["sub_reddit_id"]}')
            WHERE user_id=#{account["user_id"]}
        SQL
    )
    p "Subreddit left by user"

  end

  def self.react(account)
    results = DB.exec(
        <<-SQL
            UPDATE accounts
            SET post_reaction_id = array_append(post_reaction_id, '#{account["post_id"]}')
            WHERE user_id=#{account["user_id"]}
            RETURNING user_id, user_name, post_id, sub_reddit_id, post_reaction_id ;
        SQL
    )
    {"user_id" => results.first["user_id"].to_i,
      "username" => results.first["user_name"],
      "post_id" => results.first["title"],
      "sub_reddit_id" => results.first["sub_reddit_id"],
      "post_reaction_id" => results.first["post_reaction_id"]
      }

  end








end
