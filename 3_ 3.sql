-- количество артистов в каждом жанре

SELECT genre_id, count(artist_id) FROM ArtistsGenres
GROUP BY genre_id
ORDER BY COUNT(artist_id) DESC;

-- количество треков, вошедших в альбомы 2019-2020 гг

SELECT album_name, date_release, COUNT(track_id) FROM AlbumList albl
JOIN Track tr USING (album_id)
WHERE date_release BETWEEN '20110101' AND '20201231'
GROUP BY album_name, date_release
ORDER BY COUNT(track_id) DESC;

-- средняя продолжительность треков по каждому альбому

SELECT album_name, AVG(duration_track_sec) FROM Track tr
JOIN AlbumList albls USING (album_id )
GROUP BY Album_name;

-- все исполнители, которые не выпустили альбомы в  2020 г

SELECT artist_name FROM ListArtists WHERE artist_id NOT IN (SELECT artist_id FROM AlbumArtist AlArt
JOIN AlbumList AlLst USING (album_id) WHERE date_release BETWEEN '20200101' AND '20201231');


-- названия сборников, в которых присутствует конкретный исполнитель

SELECT album_name, COUNT(artist_id)  FROM CompilationArtist CmpArt
JOIN CompilationList CmpLst USING(album_id)
WHERE artist_id = 1
GROUP BY album_name;

-- названия сборников, в которых присутствуют исполнители более 1 жанра

SELECT album_name, COUNT(genre_id) FROM CompilationArtist
JOIN ArtistsGenres ArtGen USING (artist_id)
JOIN CompilationList Cmpls USING (album_id)
GROUP BY album_name
HAVING COUNT(genre_id) > 1;

-- наименование треков, которые не входят в сборники

SELECT track_name FROM Track WHERE track_id NOT IN (SELECT track_id FROM AlbumTrack) 
GROUP BY track_id, track_name;

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек

SELECT artist_name, duration_track_sec FROM Track Trk
JOIN AlbumArtist AlAr USING (album_id)
JOIN ListArtists Lartl USING (artist_id)
WHERE duration_track_sec = (SELECT MIN(duration_track_sec) FROM Track);


- - название альбомов, содержащих наименьшее количество треков

SELECT album_name, COUNT(track_id) FROM Track Tr
JOIN AlbumList albls USING (album_id) GROUP BY album_name
HAVING COUNT(track_id) = (SELECT MIN(nnn) FROM (SELECT album_name, COUNT(track_id) AS nnn FROM Track Tr
JOIN AlbumList albls USING (album_id) GROUP BY album_name) m);
