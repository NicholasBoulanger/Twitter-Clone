# Create the tables in the database:

CREATE TABLE twitteruser(
id SERIAL PRIMARY KEY,
username VARCHAR(40),
password VARCHAR(40)),
display_name VARCHAR(40),

CREATE TABLE tweet(
id SERIAL PRIMARY KEY,
text VARCHAR(140)),
twitteruser INTEGER REFERENCES twitteruser(id),
date TIMESTAMP,


CREATE TABLE notification(
id SERIAL PRIMARY KEY,
twitteruser INTEGER REFERENCES twitteruser(id),
viewed BOOLEAN DEFAULT FALSE);
tweet INTEGER REFERENCES tweet(id),



# PART 2
 1. Query to create a new user (username: steve, password: hunter2, display name: steve - o) 
  INSERT INTO 
    twitteruser (username, password, display_name)
  VALUES 
    ('steve', 'hunter2', 'steve - o');

2. Query to create two new users at once username: dave, password: asdf, display name: davey username: bob, password: qwer, display name: bobbinator 
  INSERT INTO 
    twitteruser (username, password, display_name) 
  VALUES 
    ('dave', 'asdf', 'davey'), 
    ('bob', 'qwer',    'bobbinator');
  
3. Query to get the username and password of twitteruser ID 1 
  SELECT (username, password) 
  FROM twitteruser WHERE id = 1;

4. Query to get the ID of a user by the username of dave 
  SELECT username FROM twitteruser WHERE username = 'dave';

5. Query to create a new tweet written by the user with the username steve (yes, you have to get the ID of Steve first) 
  INSERT INTO tweet (twitteruser, text) 
  VALUES 
    ((SELECT id FROM twitteruser WHERE username='steve'), 'first tweet!!');
  
6. Query to get the count of tweets by username steve 
  SELECT count(twitteruser) FROM Tweet 
  WHERE twitteruser=(SELECT id FROM twitteruser WHERE username='steve');  
  
7. Query to get the date and text of all tweets by username steve 
  SELECT (date, text) FROM tweet
  WHERE twitteruser=(SELECT id FROM twitteruser WHERE username='steve');
  
8. Query to get the username and password of the username bob 
  SELECT (username, password) FROM twitteruser WHERE username='bob';

9.  Query to create a notification for username bob using the tweet written by username steve 
  INSERT INTO Notification(twitteruser, tweet, viewed)
  VALUES(
    (SELECT id FROM twitteruser WHERE username='bob'),
    (SELECT id FROM tweet WHERE twitteruser=(
        SELECT id FROM twitteruser WHERE username='steve')
    ), 
    false
  );

10. Query to get all IDs of notifications for bob 
  SELECT id FROM notification
  WHERE twitteruser=(
  SELECT id FROM twitteruser WHERE username='bob'
  );


EXTRA CREDIT:

1. Extra Credit, 1pt: Query to delete a tweet starting when you already know the ID (use 1) 
    DELETE FROM tweet WHERE id=1;
    
2. Extra Credit: 2pts: Single query to delete all the tweets belonging to username bob 
    DELETE FROM tweet WHERE username = bob;
