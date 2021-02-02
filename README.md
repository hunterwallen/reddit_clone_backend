Reddit 2.0 was created by Evan Epperson, Hunter Wallen, and Kim Blanck using React, Ruby on Rails, JavaScript, Node.js, and PostgreSQL and is deployed on Heroku using version control via Github.

We aimed to create a clone of Reddit and began with the simple process of making a functional message board. We then added user authentication, which was a big part of the functionality of the app, so that users have a different experience when they are logged in vs. the public interface. We integrated many features of the original Reddit application, including subreddits that are public and private, the ability to edit and delete one's posts, popular communities, popular redditors, and a couple advertisements. 

When users are logged in, they are able to "join" subreddits, which then makes it possible to view private subreddits, as well as customize your feed to prioritize posts from subreddits you belong to. Logged in users can also create subreddits, with the option to make said subreddit public or private.

The most recently active subreddits are featured in the sidebar under "Popular Subreddits," and the most recently active users are featured under "Trending Contributors."

The application is secure via user authenticaiton using BCrypt. User passwords are never displayed in state or any other accessible area of the application, and are saved as hashes rather than plain text. We did not integrate the ability to comment on other users' posts, as we anticipated it would be quite difficult due to the possibility of various threads occurring in the comments. That would be a stretch goal. We did, however, integrate the ability to "upvote" or "downvote" posts, and once the user votes, they are unable to vote again. 

The ability to upload pictures and videos, rather than just pasting a URL, would be another stretch goal for round two.

Heroku Frontend: https://reddit-two-point-oh-react.herokuapp.com/
Heroku Backend: https://reddit-two-point-oh.herokuapp.com/