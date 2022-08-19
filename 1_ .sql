CREATE TABLE IF NOT EXISTS ListMusicalGenres (
	genre_id INTEGER PRIMARY KEY,
	genre_name VARCHAR(36) NOT NULL
	);

CREATE TABLE IF NOT EXISTS ListArtists (
	artist_id INTEGER PRIMARY KEY,
	artist_name VARCHAR(36) UNIQUE NOT NULL
	);

CREATE TABLE IF NOT EXISTS ArtistsGenres (
	artist_id INTEGER NOT NULL REFERENCES ListArtists(artist_id),
	genre_id INTEGER NOT NULL REFERENCES ListMusicalGenres(genre_id),
	CONSTRAINT pk PRIMARY KEY (artist_id, genre_id)
	);

CREATE TABLE IF NOT EXISTS AlbumList (
	album_id INTEGER PRIMARY KEY,
	album_name VARCHAR UNIQUE NOT NULL,
  	date_release DATE
	);

CREATE TABLE IF NOT EXISTS AlbumArtist (
	artist_id INTEGER NOT NULL REFERENCES ListArtists(artist_id),
	album_id INTEGER NOT NULL REFERENCES AlbumList(album_id),
	CONSTRAINT pk2 PRIMARY KEY (artist_id, album_id)
	);

CREATE TABLE IF NOT EXISTS CompilationList(
	album_id INTEGER PRIMARY KEY,
	album_name VARCHAR UNIQUE NOT NULL,
	date_release DATE
	);

CREATE TABLE IF NOT EXISTS CompilationArtist (
	artist_id INTEGER NOT NULL REFERENCES ListArtists(artist_id),
	album_id INTEGER NOT NULL REFERENCES CompilationList(album_id),
	CONSTRAINT pk1 PRIMARY KEY (artist_id, album_id)
	);

CREATE TABLE IF NOT EXISTS Track (
	track_id INTEGER PRIMARY KEY , 
	track_name VARCHAR(36) UNIQUE,
	duration_track_sec INTEGER,
	album_id INTEGER NOT NULL REFERENCES AlbumList(album_id)
	);

CREATE TABLE IF NOT EXISTS AlbumTrack (
	track_id INTEGER REFERENCES Track(track_id),
	album_id INTEGER REFERENCES CompilationList(album_id),
	artist_id INTEGER REFERENCES ListArtists(artist_id),
	CONSTRAINT tr_al PRIMARY KEY (track_id, album_id, artist_id)
	);

