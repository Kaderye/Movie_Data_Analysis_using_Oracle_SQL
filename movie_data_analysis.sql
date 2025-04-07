/*
    Project Name: Movie Data Aanalysis
    Developed by Golam Kaderye
*/

--=============================================================================

/*
    Query-1: Write a SQL query to find the name and year of the movies.
    Return movie title, movie release year with name of the month and day also.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-1:
SELECT mov_title,
to_char(to_date(mov_dt_rel, 'MM-DD-YYYY'), 'YYYY') "Release Year",
to_char(to_date(mov_dt_rel, 'mm-dd-yyyy'), 'month') "Name of Month",
to_char(to_date(mov_dt_rel, 'mm-dd-yyyy'), 'day') "Name of Day"
FROM movie_movie;

--=============================================================================

/*
    Query-2: Write a SQL query to find when the movie 'American Beauty' 
    is made. Return the year of making the movie.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-2:
SELECT mov_title, mov_year
FROM movie_movie
WHERE mov_title = 'American Beauty';

--=============================================================================

/*
    Query-3: Write a SQL query to find the movie that was made in 1999.
    Return the movie title with ID.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-3:
SELECT mov_id, mov_title
FROM movie_movie
WHERE mov_year=1999;

--=============================================================================

/*
    Query-4: Write a SQL query to find those movies, which were released before
    1998. Return movie title with released date.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-4:
SELECT mov_title, mov_dt_rel "Date of Release"
FROM movie_movie
WHERE to_char(to_date(mov_dt_rel, 'mm-dd-yyyy'), 'yyyy') < 1998;

--=============================================================================

/*
    Query-5: Write a SQL query to find the name of all reviewers and movies
    together in a single list.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;

-- solution of query-5:
SELECT mm.mov_id, mm.mov_title, mr.rev_name
FROM movie_reviewer mr
JOIN movie_rating mra ON mra.rev_id=mr.rev_id
JOIN movie_movie mm ON mm.mov_id=mra.mov_id
WHERE mr.rev_name IS NOT NULL;

--=============================================================================

/*
    Query-6: Write a SQL query to find all reviewers who have rated 7 or more 
    stars to their rating. Return reviewer name with their rating.
*/
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-6:
SELECT mr.rev_name "Reviewer Name", mra.rev_stars "Rating Stars"
FROM movie_reviewer mr
JOIN movie_rating mra ON mra.rev_id=mr.rev_id
GROUP BY mr.rev_name, mra.rev_stars
HAVING mra.rev_stars >= 7
AND mr.rev_name IS NOT NULL
ORDER BY mra.rev_stars DESC;

--=============================================================================

/*
    Query-7: Write a SQL query to find the movies with their rating is NULL.
    Return movie title with their rating is NULL.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-7:
SELECT mm.mov_title "Movie Name", mra.rev_stars "Movie Rating"
FROM movie_movie mm
JOIN movie_rating mra ON mra.mov_id=mm.mov_id
WHERE mra.rev_stars IS NULL;

--=============================================================================

/*
    Query-8: Write a SQL query to find the movies without any rating.
    Return movie title.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-8:
SELECT mm.mov_title "Movie Name"
FROM movie_movie mm
WHERE mm.mov_id NOT IN (
    SELECT mra.mov_id FROM movie_rating mra
);

--=============================================================================

/*
    Query-9: Write a SQL query to find the movies with ID 905 or 907 or 917.
    Return the movie title with their ID.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-9:
SELECT mov_id "Movie ID", mov_title "Movie Title"
FROM movie_movie
WHERE mov_id IN (905,907,917);

--=============================================================================

/*
    Query-10: Write a SQL query to find the movie titles that contain the word
    'Boogie Nights'. Sort the result-set in ascending order by the movie
    making a year. Return movie ID, movie title, movie making year
    and movie release date.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-10:
SELECT mov_id, mov_title, mov_year, mov_dt_rel
FROM movie_movie
WHERE mov_title LIKE '%Boogie%Nights%'
ORDER BY mov_year ASC;

--=============================================================================

/*
    Query-11: Write a SQL query to find those actors with the first name
    'Woddy' and the last name 'Allen'. Return details.
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;

-- solution of query-11:
SELECT *
FROM movie_actor
WHERE act_fname='Woody' AND act_lname='Allen';

--=============================================================================

/*
    Query-12: Write a SQL query to find the actors who played a role in the
    movie 'Annie Hall'. Return all the fields of the actor table.
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;
-- show the all data of movie_case table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- First way: solution of query-12:
SELECT ma.act_id,ma.act_fname, ma.act_lname, ma.act_gender
FROM movie_actor ma
JOIN movie_cast mc ON mc.act_id=ma.act_id
JOIN movie_movie mm ON mm.mov_id = mc.mov_id
WHERE mm.mov_title='Annie Hall';

-- Second way: solution of query-12:
SELECT act_id, act_fname, act_lname, act_gender
FROM movie_actor
WHERE act_id IN (
    SELECT act_id
    FROM movie_cast
    WHERE mov_id IN(
        SELECT mov_id
        FROM movie_movie
        WHERE mov_title='Annie Hall')
    );

--=============================================================================

/*
    Query-13: Write a SQL query to find the director of a film that cast a role
    in 'Miss Giddens'. Return director ID and full name.
*/
-- show the all data of movie_director table
SELECT * FROM movie_director;
-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_case table
SELECT * FROM movie_cast;

-- First way: solution of query-13:
SELECT md.dir_id "Director ID", 
md.dir_fname||' '||md.dir_lname "Full Name of Director"
FROM movie_director md
JOIN movie_direction mdi ON mdi.dir_id=md.dir_id
JOIN movie_movie mm ON mm.mov_id=mdi.mov_id
JOIN movie_cast mc ON mc.mov_id=mm.mov_id
WHERE mc.role = 'Miss Giddens';

-- Second way: solution of query-13:
SELECT dir_id "Director ID", dir_fname||' '||dir_lname "Director Full Name"
FROM movie_director
WHERE dir_id IN (
    SELECT dir_id
    FROM movie_direction
    WHERE mov_id IN (
        SELECT mov_id
        FROM movie_movie
        WHERE mov_id IN (
            SELECT mov_id
            FROM movie_cast
            WHERE role='Miss Giddens'
        )
    )
);

--=============================================================================

/*
    Query-14: Write a SQL query to find the actor of a film 
    in 'Eyes Wide Shut'. Return actor ID and full name.
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;
-- show the all data of movie_case table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- First way: solution of query-14:
SELECT ma.act_id "Acotr ID",
ma.act_fname||' '||ma.act_lname "Full Name of Actor"
FROM movie_actor ma
JOIN movie_cast mc ON mc.act_id=ma.act_id
JOIN movie_movie mm ON mm.mov_id=mc.mov_id
WHERE mm.mov_title='Eyes Wide Shut';

-- Second way: solution of query-14:
SELECT act_id "Actor ID", act_fname||' '||act_lname "Full Name of Actor"
FROM movie_actor 
WHERE act_id IN(
    SELECT act_id
    FROM movie_cast
    WHERE mov_id IN(
        SELECT mov_id
        FROM movie_movie
        WHERE mov_title='Eyes Wide Shut'
        )
    );

--=============================================================================

/*
    Query-15: Write a SQL query to find those movies that have been release
    in countries other than the United Kingdom. Return movie title, 
    movie making year, movie time, date of release and releasing country.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-15:
SELECT mov_title, mov_year, mov_time, mov_dt_rel, mov_rel_country
FROM movie_movie
WHERE mov_rel_country NOT IN 'UK';

--=============================================================================

/*
    Query-16: Write a SQL query to find for movies whose reviewer is NULL.
    Return movie title, movie making year, date of release,
    the full name of director and actor.
*/
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_director table
SELECT * FROM movie_director;

-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_actor table
SELECT * FROM movie_actor;

-- First way: solution of query-16:
SELECT mm.mov_title, mm.mov_year, mm.mov_dt_rel, 
ma.act_fname||' '||ma.act_lname "Actor Name",
md.dir_fname||' '||md.dir_lname "Director Name"
FROM movie_actor ma
JOIN movie_cast mc ON mc.act_id=ma.act_id
JOIN movie_movie mm ON mm.mov_id=mc.mov_id
JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
JOIN movie_director md ON md.dir_id=mdi.dir_id
JOIN movie_rating mr ON mr.mov_id=mm.mov_id
JOIN movie_reviewer mre ON mre.rev_id=mr.rev_id
WHERE mre.rev_name IS NULL;

-- Second way: solution of query-16:
SELECT mm.mov_title, mm.mov_year, mm.mov_dt_rel, 
ma.act_fname||' '||ma.act_lname "Actor Name",
md.dir_fname||' '||md.dir_lname "Director Name"
FROM
    movie_actor ma,
    movie_cast mc,
    movie_movie mm,
    movie_direction mdi,
    movie_director md,
    movie_rating mr,
    movie_reviewer mre
WHERE
    ma.act_id=mc.act_id
AND mc.mov_id=mm.mov_id
AND mm.mov_id=mdi.mov_id
AND mdi.dir_id=md.dir_id
AND mm.mov_id=mr.mov_id
AND mr.rev_id=mre.rev_id
AND mre.rev_name IS NULL;
    
--=============================================================================

/*
    Query-17: Write a SQL query to find those movies directed by Woody Allen. 
    Return movie title.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_director table
SELECT * FROM movie_director;

-- first way: solution of query-17:
SELECT mm.mov_title, md.dir_fname||' '||md.dir_lname "Director Name"
FROM movie_movie mm
JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
JOIN movie_director md ON md.dir_id=mdi.dir_id
WHERE md.dir_fname||' '||md.dir_lname = 'Woody Allen';

-- second way: solution of query-17:
SELECT mm.mov_title
FROM movie_movie mm
WHERE mm.mov_id=(
    SELECT mdi.mov_id
    FROM movie_direction mdi
    WHERE mdi.dir_id=(
        SELECT md.dir_id
        FROM movie_director md
        WHERE md.dir_fname||' '||md.dir_lname = 'Woody Allen'
    )
);

--=============================================================================

/*
    Query-18: Write a SQL query to determine those years in which there was at
    least one movie that received a rating of at least three starts.
    Sort the result set in ascending order by movie year. 
    Return to the movie year.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-18:
SELECT DISTINCT mm.mov_year
FROM movie_movie mm
JOIN movie_rating mr ON mr.mov_id=mm.mov_id
WHERE mr.rev_stars >= 3
ORDER BY mm.mov_year ASC;

--=============================================================================

/*
    Query-19: Write a SQL query to search for movies that do not have any
    ratings. Return movie title.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-19:
SELECT DISTINCT mov_title
FROM movie_movie
WHERE mov_id NOT IN (
        SELECT mov_id
        FROM movie_rating
);

--=============================================================================

/*
    Query-20: Write a SQL query to find those reviewers who have not given a 
    rating of certain films. Return reviewer name.
*/
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-20:
SELECT rev_name
FROM movie_reviewer
WHERE rev_id IN(
    SELECT rev_id
    FROM movie_rating
    WHERE rev_stars IS NULL
);

--=============================================================================

/*
    Query-21: Write a SQL query to find movies that have been reviewed by a
    reviewer and received a rating. Sort the result set ascending order by
    reviewer name, movie title, review stars. Return reviewer name, movie
    title, review stars.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;

-- solution of query-21:
SELECT mm.mov_title, mre.rev_name, mr.rev_stars
FROM movie_movie mm, movie_rating mr, movie_reviewer mre
WHERE mm.mov_id=mr.mov_id
AND mre.rev_id=mr.rev_id
AND mre.rev_name IS NOT NULL
AND mr.rev_stars IS NOT NULL
ORDER BY mm.mov_title, mre.rev_name, mr.rev_stars;

--=============================================================================

/*
    Query-22: Write a SQL query to find movies that have been reviewed by a 
    reviewer and received a rating. Group the result set on the reviewer's name,
    movie title. Return reviewer's name, movie title.
*/
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-22:
SELECT mre.rev_name, mm.mov_title
FROM movie_reviewer mre
JOIN movie_rating r1 ON r1.rev_id=mre.rev_id 
JOIN movie_movie mm ON mm.mov_id=r1.mov_id
JOIN movie_rating r2 ON r2.rev_id = r1.rev_id
GROUP BY mre.rev_name, mm.mov_title
HAVING COUNT(*) > 1;

--=============================================================================

/*
    Query-23: Write a SQL query to find those movies, which have received the
    highest number of stars. Group the result set on the movie title and sort
    the result set in ascending order by the movie title. Return movie title
    and maximum number of review stars.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- frist way: solution of query-23:
SELECT 
    mm.mov_title "Movie Name",
    MAX(mr.rev_stars) "Review Rating"
FROM movie_movie mm
JOIN movie_rating mr ON mr.mov_id=mm.mov_id
GROUP BY mm.mov_title, mr.rev_stars
HAVING mr.rev_stars IS NOT NULL
ORDER BY "Movie Name" ASC;

-- second way: solution of query-23:
SELECT
    mm.mov_title "Movie Name",
    MAX(mr.rev_stars) "Review Rating"
FROM movie_movie mm, movie_rating mr
WHERE mm.mov_id=mr.mov_id
AND mr.rev_stars IS NOT NULL
GROUP BY mm.mov_title, mr.rev_stars
ORDER BY mm.mov_title;

--=============================================================================

/*
    Query-24: Write a SQL query to find all reviewers who rated the movie
    'American Beauty'. Return reviewer name.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;

-- frist way: solution of query-24:
SELECT mre.rev_name, mm.mov_title, mr.rev_stars
FROM movie_reviewer mre
JOIN movie_rating mr ON mr.rev_id=mre.rev_id
JOIN movie_movie mm ON mm.mov_id=mr.mov_id
WHERE mm.mov_title='American Beauty';

-- second way: solution of query-24:
SELECT 
    mre.rev_name "Reviewer Name",
    mm.mov_title "Movie Name",
    mr.rev_stars "Reviewer Stars"
FROM movie_reviewer mre, movie_rating mr, movie_movie mm
WHERE mm.mov_id=mr.mov_id
AND mr.rev_id=mre.rev_id
AND mm.mov_title='American Beauty'; 

--=============================================================================

/*
    Query-25: Write a SQL query to find the movies that have not been reviewed
    by any reviewer body other than 'Paul Monks'. Return movie title.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;

-- frist way: solution of query-25:
SELECT mm.mov_title
FROM movie_movie mm
WHERE mm.mov_id IN(
    SELECT mr.mov_id
    FROM movie_rating mr
    WHERE mr.rev_id NOT IN(
        SELECT mre.rev_id
        FROM movie_reviewer mre
        WHERE mre.rev_name='Paul Monks'
    )
);

-- second way: solution of query-25:
SELECT mm.mov_title, mre.rev_name
FROM movie_movie mm
JOIN movie_rating mr ON mr.mov_id=mm.mov_id
JOIN movie_reviewer mre ON mre.rev_id=mr.rev_id
WHERE mre.rev_id NOT IN (
    SELECT mre.rev_id 
    FROM movie_reviewer 
    WHERE mre.rev_name='Paul Monks'
);

--=============================================================================

/*
    Query-26: Write a SQL query to find the movies with the lowest ratings.
    Return reviewer name, movie title and number of stars for those movies.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;

-- frist way: solution of query-26:
SELECT
    mre.rev_name "Reviewer Name",
    mm.mov_title "Movie Title",
    mr.rev_stars "Number of Stars"
FROM movie_movie mm
JOIN movie_rating mr ON mr.mov_id=mm.mov_id
JOIN movie_reviewer mre ON mre.rev_id=mr.rev_id
WHERE mre.rev_name IS NOT NULL
ORDER BY mr.rev_stars
FETCH FIRST 1 ROW ONLY;

-- second way: solution of query-26:
SELECT
    mre.rev_name "Reviewer Name",
    mm.mov_title "Movie Title",
    mr.rev_stars "Number of Stars"
FROM movie_movie mm, movie_rating mr, movie_reviewer mre
WHERE mm.mov_id=mr.mov_id
AND mr.rev_id=mre.rev_id
AND mr.rev_stars=(
    SELECT MIN(mr.rev_stars)
    FROM movie_rating mr
);

--=============================================================================

/*
    Query-27: Write a SQL query to find the movies directed by 'James Cameron'.
    Return movie title.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_director table
SELECT * FROM movie_director;

-- frist way: solution of query-27:
SELECT
    mm.mov_title "Movie Name",
    md.dir_fname||' '||md.dir_lname "Director Name"
FROM movie_movie mm
JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
JOIN movie_director md ON md.dir_id=mdi.dir_id
WHERE md.dir_fname||' '||md.dir_lname='James Cameron';

-- second way: solution of query-27:
SELECT
    mm.mov_title "Movie Name",
    md.dir_fname||' '||md.dir_lname "Director Name"
FROM movie_movie mm, movie_direction mdi, movie_director md
WHERE mdi.mov_id=mm.mov_id
AND md.dir_id=mdi.dir_id
AND md.dir_fname||' '||md.dir_lname='James Cameron';

--=============================================================================

/*
    Query-28: Write a SQL query to find the movies in which one or more actors
    appeared in more than one film.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_actor table
SELECT * FROM movie_actor;

-- count number of movie based on act_id
SELECT mc.act_id, COUNT(mm.mov_title)
FROM movie_movie mm
JOIN movie_cast mc ON mc.mov_id = mm.mov_id
JOIN movie_actor ma ON ma.act_id = mc.act_id
GROUP BY mc.act_id
HAVING COUNT(mm.mov_title)>1;

-- NOW, solution of query-28:
SELECT mm.mov_title
FROM movie_movie mm
JOIN movie_cast mc ON mc.mov_id = mm.mov_id
JOIN movie_actor ma ON ma.act_id = mc.act_id
WHERE ma.act_id IN (
    SELECT mc.act_id
    FROM movie_cast mc
    GROUP BY mc.act_id
    HAVING COUNT(mc.act_id) > 1
);

--=============================================================================

/*
    Query-29: Write a SQL query to find all reviewers whose ratings contain a
    NULL value. Return reviewer name.
*/
-- show the all data of movie_reviewer table
SELECT * FROM movie_reviewer;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-29:
SELECT
    mre.rev_name "Reviewer Name",
    mr.rev_stars "Reviewer Rating"
FROM movie_rating mr
JOIN movie_reviewer mre ON mre.rev_id=mr.rev_id
WHERE mr.rev_stars IS NULL;

--=============================================================================

/*
    Query-30: Write a SQL query to find out who was cast in the movie
    'Annie Hall'. Return the full name of the actor and role.
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;
-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-30:
SELECT 
    ma.act_fname||' '||ma.act_lname "Full Name of Actor",
    mc.role "Role", 
    mm.mov_title
FROM movie_actor ma
JOIN movie_cast mc ON mc.act_id=ma.act_id
JOIN movie_movie mm ON mm.mov_id=mc.mov_id
WHERE mm.mov_title='Annie Hall';

--=============================================================================

/*
    Query-31: Write a SQL query to find the director who directed a movie that
    featured a role in 'Elizabeth Darko'. Return the name of 
    the director and movie.
*/
-- show the all data of movie_director table
SELECT * FROM movie_director;
-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_cast table
SELECT * FROM movie_cast;

-- solution of query-31:
SELECT 
    md.dir_fname||' '||md.dir_lname "Director Name",
    mm.mov_title "Movie Name"
FROM movie_director md
JOIN movie_direction mdi ON mdi.dir_id=md.dir_id
JOIN movie_movie mm ON mm.mov_id=mdi.mov_id
JOIN movie_cast mc ON mc.mov_id=mm.mov_id
WHERE mc.role='Elizabeth Darko';

--=============================================================================

/*
    Query-32: Write a SQL query to find the director of a movie
    is Eyes Wide Shut. Return the full name of director and role.
*/
-- the related table names are:
-- movie_director, movie_direction, movie_movie, movie_cast

-- solution of query-32:
SELECT 
    md.dir_fname||' '||md.dir_lname "Director Name",
    mc.role "Role"
FROM movie_director md
JOIN movie_direction mdi ON mdi.dir_id=md.dir_id
JOIN movie_movie mm ON mm.mov_id=mdi.mov_id
JOIN movie_cast mc ON mc.mov_id=mm.mov_id
WHERE mm.mov_title='Eyes Wide Shut';

--=============================================================================

/*
    Query-33: Write a SQL query to find out which actors have not appeared in
    any movies between 1990 and 2000 (Begin and end values are included).
    Return the full name of the actor, movie title and date of release.
*/
-- the related table names are:
-- movie_actor, movie_cast, movie_movie

-- solution of query-33:
COLUMN "Movie Make Year" FORMAT A15 JUSTIFY LEFT
SELECT
    ma.act_fname||' '||ma.act_lname "Actor Name",
    mm.mov_title "Movie Name",
    mm.mov_year "Movie Make Year",
    mm.mov_dt_rel "Date of Release"
FROM movie_actor ma
JOIN movie_cast mc ON mc.act_id=ma.act_id
JOIN movie_movie mm ON mm.mov_id=mc.mov_id
WHERE mm.mov_year NOT BETWEEN 1990 AND 2000;

--=============================================================================

/*
    Query-34: Write a SQL query to find the directors who have directed films
    in a variety of genres. Group the result set on director first name, last
    name and generic title. Sort the result set in ascending order by director
    first name and last name. Return director first name, last name, generic
    title and number of genres of movies.
*/
-- the related table names are:
-- movie_director, movie_gen_genres

-- solution of query-34:
SELECT 
    md.dir_fname "First Name",
    md.dir_lname "Last Name",
    mg.gen_title "Generic Title",
    COUNT(mgg.gen_id) "Number of genres"
FROM 
    movie_director md
    JOIN movie_direction mdi ON mdi.dir_id = md.dir_id
    JOIN movie_movie mm ON mm.mov_id=mdi.mov_id
    JOIN movie_gen_genres mgg ON mgg.mov_id=mm.mov_id
    JOIN movie_genres mg ON mg.gen_id=mgg.gen_id
GROUP BY 
    md.dir_fname, md.dir_lname, mg.gen_title
ORDER BY
    md.dir_fname, md.dir_lname;

--=============================================================================

/*
    Query-35: Write a SQL query to find the movies with year and genres. 
    Return movie title, movie make year and generic title.
*/
-- the related table names are:
-- movie_movie, movie_gen_genres, movie_genres

-- solution of query-35:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Movie Make Year",
    mg.gen_title "Generic Title"
FROM 
    movie_movie mm
    JOIN movie_gen_genres mgg ON mgg.mov_id=mm.mov_id
    JOIN movie_genres mg ON mg.gen_id=mgg.gen_id;

--=============================================================================

/*
    Query-36: Write a SQL query to find all the movies with year, genres and
    name of the director.
*/
-- the related table names are:
-- movie_director, movie_direction, movie_movie, movie_gen_genres, movie_genres

-- solution of query-36:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Movie Make Year",
    mg.gen_title "Generic Title",
    md.dir_fname||' '||md.dir_lname "Director Name"
FROM
    movie_director md
    NATURAL JOIN movie_direction mdi
    NATURAL JOIN movie_movie mm
    NATURAL JOIN movie_gen_genres mgg
    NATURAL JOIN movie_genres mg;

--=============================================================================

/*
    Query-37: Write a SQL query to find the movies released before
    1978. Sort the result set in descending order by movie make year. Return 
    movie title, movie year, date of release, duration 
    and the name of the director.
*/
-- the related table names are:
-- movie_director, movie_direction, movie_movie

-- solution of query-37:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Movie Make Year",
    mm.mov_dt_rel "Date of Release",
    mm.mov_time "Duration",
    md.dir_fname||' '||md.dir_lname "Director Name"
FROM
    movie_director md
    JOIN movie_direction mdi ON mdi.dir_id=md.dir_id
    JOIN movie_movie mm ON mm.mov_id=mdi.mov_id
WHERE 
    mm.mov_year < 1978
ORDER BY
    mm.mov_dt_rel DESC;

--=============================================================================

/*
    Query-38: Write a SQL query to calculate the average movie length
    and count the number of movies in each genre. Return genre title,
    average time and number of movies for each genre.
*/
-- the related table names are:
-- movie_genre, movie_gen_genres, movie_movie

-- solution of query-38:
SELECT
    mg.gen_title "Generic Title",
    ROUND(AVG(mm.mov_time), 2) "Average Time",
    COUNT(mm.mov_title) "Number of Movies / Generic"
FROM
    movie_genres mg
    JOIN movie_gen_genres mgg ON mgg.gen_id=mg.gen_id
    JOIN movie_movie mm ON mm.mov_id=mgg.mov_id
GROUP BY mg.gen_title
ORDER BY mg.gen_title;

--=============================================================================

/*
    Query-39: Write a SQL query to find the movies with the shortest duration.
    Return movie title, movie year, director name, actor name and role.
*/
-- the related table names are:
-- movie_movie, movie_cast, movie_actor, movie_direction, movie_director

-- solution of query-39:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Movie Make Year",
    md.dir_fname||' '||md.dir_lname "Director Name",
    ma.act_fname||' '||ma.act_lname "Actor Name"
FROM
    movie_movie mm
    JOIN movie_cast mc ON mc.mov_id=mm.mov_id
    JOIN movie_actor ma ON ma.act_id=mc.act_id
    JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
    JOIN movie_director md ON md.dir_id=mdi.dir_id
WHERE
    mm.mov_time =(
    SELECT MIN(mm.mov_time) FROM movie_movie mm
    );

--=============================================================================

/*
    Query-40: Write a SQL query to find the years in which a movie received
    a rating of 3 or 4. Sort the result in increasing order on movie year.
*/
-- the related table names are:
-- movie_movie, movie_rating

-- solution of query-40:
SELECT
    mm.mov_year, mr.rev_stars
FROM 
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
WHERE
    mr.rev_stars IN (3, 4)
ORDER BY
    mm.mov_year ASC;

--=============================================================================

/*
    Query-41: Write a SQL query to get the reviewer name, movie title, 
    and stars in an order that reviewer name will come first, 
    then by movie title, and lastly by number of stars.  
*/
-- the related table names are:
-- movie_reviewer, movie_rating, movie_movie

-- solution of query-41:
SELECT
    mre.rev_name "Reviewer Name",
    mm.mov_title "Movie Title",
    mr.rev_stars "Reviewer Stars"
FROM
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
    JOIN movie_reviewer mre ON mre.rev_id=mr.rev_id
GROUP BY
    mre.rev_name,mm.mov_title,mr.rev_stars
HAVING
    mre.rev_name IS NOT NULL
ORDER BY
    1,2,3;

--=============================================================================

/*
    Query-42: Write a SQL query to find those movies that have at least 
    one rating and received the most stars. Sort the result-set on the 
    movie title. Return movie title and maximum review stars.  
*/
-- the related table names are:
-- movie_movie, movie_rating

-- solution of query-42:
SELECT
    mm.mov_title "Movie Title",
    MAX(mr.rev_stars) "Maximum Review Stars"
FROM
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
    AND mr.rev_stars >=1
GROUP BY
    mm.mov_title
ORDER BY
    mm.mov_title;

--=============================================================================

/*
    Query-43: Write a SQL query to find out which movies have  received a number
    of ratings. Return movie title, director name and number of ratings.
*/
-- the related table names are:
-- movie_movie, movie_direction, movie_director, movie_rating

-- solution of query-43:
SELECT
    mm.mov_title "Movie Title",
    md.dir_fname||' '||md.dir_lname "Director Name",
    mr.num_o_ratings "Number of Ratings"
FROM
    movie_movie mm
    JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
    JOIN movie_director md ON md.dir_id=mdi.dir_id
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
GROUP BY
    mm.mov_title,md.dir_fname||' '||md.dir_lname,mr.num_o_ratings
HAVING 
    mr.num_o_ratings IS NOT NULL
ORDER BY
    mr.num_o_ratings DESC;

--=============================================================================

/*
    Query-44: Write a SQL query to find movies in which one or more actors 
    have acted in more than one film. Return movie title, actor name, 
    and the role.  
*/
-- the related table names are:
-- movie_movie, movie_actor, movie_cast

-- solution of query-44:
SELECT
    mm.mov_title "Movie Title",
    ma.act_fname||' '||ma.act_lname "Actor Name",
    mc.role "Role"
FROM
    movie_movie mm
    JOIN movie_cast mc ON mc.mov_id=mm.mov_id
    JOIN movie_actor ma ON ma.act_id=mc.act_id
WHERE
    ma.act_id IN(
        SELECT mc.act_id
        FROM movie_cast mc
        GROUP BY mc.act_id
        HAVING COUNT(mc.act_id)>=2
    );

--=============================================================================

/*
    Query-45: Write a SQL query to find the actor whose first name is 
    'Claire' and last name is 'Danes'. Return movie title, the full name 
    of director and actor and their role. 
*/
-- the related table names are:
-- movie_director, movie_direction, movie_movie, movie_cast, movie_actor

-- solution of query-45:
SELECT
    mm.mov_title "Movie Title",
    md.dir_fname||' '||md.dir_lname "Director Name",
    ma.act_fname||' '||ma.act_lname "Actor Name",
    mc.role "Role"
FROM
    movie_actor ma
    JOIN movie_cast mc ON mc.act_id=ma.act_id
    JOIN movie_movie mm ON mm.mov_id=mc.mov_id
    JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
    JOIN movie_director md ON md.dir_id=mdi.dir_id
WHERE
    ma.act_fname='Claire' AND ma.act_lname='Danes';

--=============================================================================

/*
    Query-46: Write a SQL query to find for actors whose films have been 
    directed by them. Return actor name, movie title and role.  
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;
-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_director table
SELECT * FROM movie_director;

-- solution of query-46:
SELECT
    ma.act_fname||' '||ma.act_lname "Actor Name",
    mm.mov_title "Movie Title",
    mc.role "Role"
FROM
    movie_actor ma
    JOIN movie_cast mc ON mc.act_id=ma.act_id
    JOIN movie_movie mm ON mm.mov_id=mc.mov_id
    JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
    JOIN movie_director md ON md.dir_id=mdi.dir_id
WHERE
    ma.act_fname=md.dir_fname
    AND ma.act_lname=md.dir_lname;

--=============================================================================

/*
    Query-47: Write a SQL query to find the cast list of the movie ‘Chinatown’.
    Return the name of the actor. 
*/
-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_actor table
SELECT * FROM movie_actor;

-- solution of query-47:
SELECT
    ma.act_fname||' '||ma.act_lname "Actor Name"
FROM
    movie_actor ma
    JOIN movie_cast mc ON mc.act_id=ma.act_id
    JOIN movie_movie mm ON mm.mov_id=mc.mov_id
WHERE
    mm.mov_title='Chinatown';

--=============================================================================

/*
    Query-48: Write a SQL query to find those movies where the actor’s 
    name is 'Harrison Ford'. Return movie title. 
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;
-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-48:
SELECT
    mm.mov_title "Movie Name"
FROM
    movie_movie mm
    JOIN movie_cast mc ON mc.mov_id=mm.mov_id
    JOIN movie_actor ma ON ma.act_id=mc.act_id
WHERE
    ma.act_fname||' '||ma.act_lname='Harrison Ford';

--=============================================================================

/*
    Query-49: Write a SQL query to find the highest-rated movies. 
    Return movie title, movie year, review stars and releasing country.
*/
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- first way: solution of query-49:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Movie Year",
    mr.rev_stars "Reveiewer Stars",
    mm.mov_rel_country "Release Country"
FROM
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
GROUP BY
    mm.mov_title, mm.mov_year, mr.rev_stars, mm.mov_rel_country
HAVING
    mr.rev_stars IS NOT NULL
ORDER BY
    mr.rev_stars DESC
FETCH FIRST 1 ROW ONLY;

-- second way: solution of query-49:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Movie Year",
    mr.rev_stars "Reveiewer Stars",
    mm.mov_rel_country "Release Country"
FROM
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
WHERE
    mr.rev_stars=(
        SELECT MAX(mr.rev_stars)
        FROM movie_rating mr
    );

--=============================================================================

/*
    Query-50: Write a SQL query to find the highest-rated ‘Thriller’ movies. 
    Return the movie title, movie year and rating. 
*/
-- show the all data of movie_genres table
SELECT * FROM movie_genres;
-- show the all data of movie_gen_genres table
SELECT * FROM movie_gen_genres;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-50:
SELECT
    mm.mov_title "Movie Title",
    mm.mov_year "Year",
    mr.rev_stars "Rating"
FROM
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
    JOIN movie_gen_genres mgg ON mgg.mov_id=mm.mov_id
    JOIN movie_genres mg ON mg.gen_id=mgg.gen_id
WHERE
    mg.gen_title='Thriller';

--=============================================================================

/*
    Query-51: Write a SQL query to find the years when most of the 
    ‘Crime’ movies produced. Count the number of generic titles
    and compute their average rating. Group the result set on movie 
    release year, generic title. Return movie year, generic title, 
    number of generic titles and average rating. 
*/
-- show the all data of movie_genres table
SELECT * FROM movie_genres;
-- show the all data of movie_gen_genres table
SELECT * FROM movie_gen_genres;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;

-- solution of query-51:
SELECT
    mm.mov_year "Movie Year",
    mg.gen_title "Generic Title",
    COUNT(mg.gen_title) "Number of Generic Title",
    AVG(mr.rev_stars) "Average Rating"
FROM
    movie_movie mm
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
    JOIN movie_gen_genres mgg ON mgg.mov_id=mm.mov_id
    JOIN movie_genres mg ON mg.gen_id=mgg.gen_id
GROUP BY
    mm.mov_year, mg.gen_title
HAVING
    mg.gen_title='Crime';

--=============================================================================

/*
    Query-52: Write a SQL query to generate a report, which contain the 
    fields movie title, name of the female actor, year of the movie, role, 
    movie genres, the director, date of release, 
    and the number of ratings for that movie. 
*/
-- show the all data of movie_actor table
SELECT * FROM movie_actor;
-- show the all data of movie_cast table
SELECT * FROM movie_cast;
-- show the all data of movie_movie table
SELECT * FROM movie_movie;
-- show the all data of movie_direction table
SELECT * FROM movie_direction;
-- show the all data of movie_director table
SELECT * FROM movie_director;
-- show the all data of movie_gen_genres table
SELECT * FROM movie_gen_genres;
-- show the all data of movie_genres table
SELECT * FROM movie_genres;
-- show the all data of movie_rating table
SELECT * FROM movie_rating;

-- solution of query-52:
SELECT
    mm.mov_title "Movie Title",
    ma.act_fname||' '||ma.act_lname "Female Actor",
    mm.mov_year "Movie Year",
    mc.role "Role",
    mg.gen_title "Generic Title",
    md.dir_fname||' '||md.dir_lname "Director Name",
    mm.mov_dt_rel "Date of Release",
    mr.num_o_ratings "Number of Ratings"
FROM
    movie_actor ma
    JOIN movie_cast mc ON mc.act_id=ma.act_id
    JOIN movie_movie mm ON mm.mov_id=mc.mov_id
    JOIN movie_direction mdi ON mdi.mov_id=mm.mov_id
    JOIN movie_director md ON md.dir_id=mdi.dir_id
    JOIN movie_gen_genres mgg ON mgg.mov_id=mm.mov_id
    JOIN movie_genres mg ON mg.gen_id=mgg.gen_id
    JOIN movie_rating mr ON mr.mov_id=mm.mov_id
WHERE
    ma.act_gender='F';

--=============================================================================
--  ++++++++++++++++++++++ The End ++++++++++++++++++++++++
--=============================================================================
