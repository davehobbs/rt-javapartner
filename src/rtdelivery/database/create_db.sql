CREATE TABLE destinations ( destination VARCHAR);
CREATE TABLE platforms ( platform VARCHAR, hybrid INTEGER); 
CREATE TABLE files 
    (id INTEGER PRIMARY KEY autoincrement, 
    vendor STRING NOT NULL, 
    bldlang STRING NOT NULL, 
    technology STRING NOT NULL, 
    version_group STRING NOT NULL, 
    platform STRING NOT NULL, 
    file STRING NOT NULL, 
    destination STRING, 
    chksum_srcfile STRING, 
    fmt_seqno STRING, 
    jim_seqno STRING);

CREATE TABLE destination_restrictions ( destination VARCHAR, min_release FLOAT, max_release FLOAT, platforms VARCHAR, access BOOLEAN);
CREATE TABLE source_locations ( vendor STRING NOT NULL, min_release FLOAT, max_release FLOAT, source STRING NOT NULL);

-- Common attributes used when delivering a group of releases
CREATE TABLE Delivery_stream (
    stream_name VARCHAR PRIMARY KEY,
    vendor VARCHAR NOT NULL,
    bldlang VARCHAR NOT NULL,
    technology VARCHAR NOT NULL,
UNIQUE(vendor, bldlang, technology)
);

-- A set of v.r/platform items for eache release stream
CREATE TABLE Delivery_release (
    id INTEGER PRIMARY KEY autoincrement,
    delivery_stream VARCHAR NOT NULL,
    version_group VARCHAR NOT NULL,
    platform NOT NULL,
UNIQUE(release_stream, version_group, platform)
);

-- A set of file patterns for each release platform
CREATE TABLE Delivery_file (
    id INTEGER PRIMARY KEY autoincrement,
    delivery_release_id INTEGER,
    file_pattern STRING VARCHAR NOT NULL,
UNIQUE(delivery_release_id, file_pattern),
CONSTRAINT fk_delivery_release
FOREIGN KEY (Delivery_release)
REFERENCES Delivery_release(id)
);

-- Where files are being delivered 
CREATE TABLE File_destinations (
    delivery_file_id int, 
    destination varchar(10),
UNIQUE(delivery_file_id, destination),
);

CREATE VIEW Release_destinations
AS
SELECT
   releases.version_group,
   files.file_pattern,
   destination
FROM
   file_destination
INNER JOIN files ON delivery_file.id = file_destinations.delivery_file_id
INNER JOIN releases ON delivery_release.id = delivery_file.release_id;