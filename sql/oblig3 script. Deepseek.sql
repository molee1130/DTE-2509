-- Create User Table
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    fornavn VARCHAR(50) NOT NULL,
    etternavn VARCHAR(50) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create Address Table
CREATE TABLE Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type ENUM('home', 'billing', 'pickup', 'delivery', 'other') NOT NULL,
    street VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Create Car Table
CREATE TABLE Car (
    registreringsnummer VARCHAR(20) PRIMARY KEY,
    user_id INT NOT NULL,
    merke VARCHAR(50) NOT NULL,
    modell VARCHAR(50) NOT NULL,
    årsmodell YEAR NOT NULL,
    effekt INT NOT NULL,
    gruppe ENUM('Personbil', 'Lastebil', 'Andre') NOT NULL,
    firehjulsdrift BOOLEAN NOT NULL,
    drivlinje ENUM('elektrisk', 'diesel', 'bensin', 'hydrogen') NOT NULL,
    kjæledyr_tillatt BOOLEAN NOT NULL,
    røyking_tillatt BOOLEAN NOT NULL,
    pris_per_døgn DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Create Booking Table
CREATE TABLE Booking (
    bookingnummer INT AUTO_INCREMENT PRIMARY KEY,
    car_id VARCHAR(20) NOT NULL,
    leietaker_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    hente_adresse_id INT NOT NULL,
    levering_adresse_id INT NOT NULL,
    start_km INT,
    end_km INT,
    utleier_rating TINYINT CHECK (utleier_rating BETWEEN 1 AND 5),
    leietaker_rating TINYINT CHECK (leietaker_rating BETWEEN 1 AND 5),
    FOREIGN KEY (car_id) REFERENCES Car(registreringsnummer),
    FOREIGN KEY (leietaker_id) REFERENCES User(user_id),
    FOREIGN KEY (hente_adresse_id) REFERENCES Address(address_id),
    FOREIGN KEY (levering_adresse_id) REFERENCES Address(address_id)
);

-- Create Message Table
CREATE TABLE Message (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    from_user_id INT NOT NULL,
    to_user_id INT NOT NULL,
    parent_message_id INT,
    booking_id INT,
    timestamp DATETIME NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (from_user_id) REFERENCES User(user_id),
    FOREIGN KEY (to_user_id) REFERENCES User(user_id),
    FOREIGN KEY (parent_message_id) REFERENCES Message(message_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(bookingnummer)
);