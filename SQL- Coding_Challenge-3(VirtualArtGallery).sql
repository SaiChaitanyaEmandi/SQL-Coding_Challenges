CREATE DATABASE VirtualArtGallery_CodingChallenge;
use VirtualArtGallery_CodingChallenge;

CREATE TABLE Artists 
(
 ArtistId INT PRIMARY KEY,
 Name VARCHAR(50) NOT NULL,
 Biography VARCHAR(150),
 Nationality VARCHAR(20)
 );

 CREATE TABLE Categories 
 (
 CategoryID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL ); CREATE TABLE Artworks
 (
 ArtworkId INT PRIMARY KEY,
 Title VARCHAR(50) NOT NULL,
 ArtistId INT  FOREIGN KEY (ArtistId) REFERENCES Artists (ArtistId),
 CategoryId INT FOREIGN KEY (CategoryId) REFERENCES Categories (CategoryId),
 Year INT,
 Description VARCHAR(150),
 ImageURL VARCHAR(100),
 ); DROP TABLE Artworks;  DROP TABLE Artists; CREATE TABLE Exhibitions
 (
 ExhibitionId INT PRIMARY KEY,
 Title VARCHAR(50) NOT NULL,
 StartDate DATE,
 EndDate DATE,
 Description VARCHAR(150)
 );

 CREATE TABLE ExhibitionArtworks 
 (
 ExhibitionId INT,
 ArtworkId INT,
 PRIMARY KEY (ExhibitionID, ArtworkID),
 FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
 FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)
 );

CREATE TABLE Gallery
(
	GalleryId INT PRIMARY KEY,
	Name VARCHAR(30),
	Description VARCHAR(100),
	Location VARCHAR(50),
	Curator INT FOREIGN KEY (Curator) REFERENCES Artists(ArtistId),
	OpeningHours VARCHAR(100)
);

 INSERT INTO Artists
 VALUES(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
 (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
 (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

INSERT INTO Categories 
VALUES(1, 'Painting'),
 (2, 'Sculpture'),
 (3, 'Photography');INSERT INTO Artworks  
VALUES(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picassos powerful anti-war mural.', 'guernica.jpg');INSERT INTO Exhibitions  
VALUES(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
 (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');INSERT INTO ExhibitionArtworks
VALUES(1, 1),
(1, 2),
(1, 3),
(2, 2);INSERT INTO Gallery 
VALUES(101, 'Gallery A', 'Contemporary Art', '123 Main Street', 1, '10:00 AM - 6:00 PM'),
(102, 'Gallery B', 'Modern Art', '456 Elm Street', 2, '11:00 AM - 7:00 PM'),
(103, 'Gallery C', 'Abstract Art', '789 Oak Street', 3, '9:00 AM - 5:00 PM');--Q2SELECT Title FROM Artworks AWJOIN Artists A ON AW.ArtistId = A.ArtistIdWHERE A.Nationality IN ('Spanish', 'Dutch' )ORDER BY YEAR DESC;