DROP DATABASE IF EXISTS RailwayDB;
CREATE DATABASE RailwayDB;
USE RailwayDB;

CREATE TABLE USER_TABLE (
    Email_ID varchar(30) not null PRIMARY KEY,
    Password varchar(10) not null,
    Name varchar(30) not null,
    Gender varchar(8) not null,
    Age INT not null,
    Mobile varchar(10) not null,
    City varchar(20) not null,
    State varchar(30) not null
);

CREATE TABLE STATION (
    Station_ID varchar(10) not null PRIMARY KEY,
    Station_name varchar(30)
);

CREATE TABLE PASSENGER_TICKET (
    PNR varchar(30) not null PRIMARY KEY,
    Class varchar(30) not null,
    Reservation_status varchar(10) not null,
    Source_ID varchar(10) not null,
    Destination_ID varchar(10) not null,
    Fare int not null,
    FOREIGN KEY (Source_ID) REFERENCES STATION (Station_ID),
    FOREIGN KEY (Destination_ID) REFERENCES STATION (Station_ID)
);

CREATE TABLE PASSENGER (
    PNR varchar(30) not null,
    Passenger_name varchar(30) not null,
    Gender varchar(8) not null,
    Seat_number int not null PRIMARY KEY,
    Age int not null,
    FOREIGN KEY(PNR) REFERENCES PASSENGER_TICKET(PNR)
);

CREATE TABLE TRAIN (
    Train_ID INT not null PRIMARY KEY,
    Train_name varchar(30) not null,
    Train_type varchar(20) not null,
    Source_ID varchar(10) not null,
    Destination_ID varchar(10)  not null,
    Available_classes varchar(20) not null,
    FOREIGN KEY (Source_ID) REFERENCES STATION (Station_ID),
    FOREIGN KEY (Destination_ID) REFERENCES STATION (Station_ID)
);

CREATE TABLE DAYS_AVAILABLE (
    Train_ID INT not null,
    Available_days varchar(30) not null PRIMARY KEY,
    FOREIGN KEY (Train_ID) REFERENCES TRAIN (Train_ID)
);

CREATE TABLE TRAIN_STATUS (
    Train_ID int not null,
    Available_date varchar(20) not null PRIMARY KEY,
    Booked_seats int not null,
    Waiting_seats int not null,
    Available_seats int not nulL,
    FOREIGN KEY (Train_ID) REFERENCES TRAIN (Train_ID)
);

CREATE TABLE ROUTES (
    Train_ID int not null,
    Stop_number int not null PRIMARY KEY,
    Arrival_time text not null,
    Departure_time text not null,
    Source_distance int not null,
    FOREIGN KEY (Train_ID) REFERENCES TRAIN (Train_ID)
);

CREATE TABLE RESERVATION (
    PNR varchar(30) not null,
    Train_ID INT not null,
    Email_ID varchar(30) not null,
    Available_date varchar(20) not null,
    Status varchar(20) null,
    CONSTRAINT PK_RESERVATION PRIMARY KEY (Train_ID, Available_date, Email_ID, PNR),
    FOREIGN KEY (Train_ID, Available_date) REFERENCES TRAIN_STATUS (Train_ID, Available_date),
    FOREIGN KEY (Email_ID) REFERENCES USER_TABLE (EMAIL_ID),
    FOREIGN KEY (PNR) REFERENCES PASSENGER_TICKET (PNR)
);

CREATE TABLE ROUTE_HAS_STATION (
    Train_ID INT not null,
    Station_ID varchar(10) not null,
    Stop_number int not null,
    CONSTRAINT PK_ROUTE_HAS_STATION PRIMARY KEY (Train_ID, Stop_number, Station_ID),
    FOREIGN KEY (Train_ID, Stop_number) REFERENCES ROUTES (Train_ID, Stop_number),
    FOREIGN KEY (Station_ID) REFERENCES STATION (Station_ID)
);
