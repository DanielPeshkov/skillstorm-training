class Flight:

    def __init__(self, flight_number, departure_city, arrival_city, departure_time, seat_capacity=150) -> None:
        self.passenger_list = []
        self.flight_number = flight_number
        self.departure_city = departure_city
        self.arrival_city = arrival_city
        self.departure_time = departure_time
        self.seat_capacity = seat_capacity

    def add_passenger(self, passenger):
        if len(self.passenger_list) < self.seat_capacity:
            self.passenger_list.append(passenger)
        else:
            print("Cannot add passenger, flight is full")

    def remove_passenger(self, passenger):
        if passenger in self.passenger_list:
            self.passenger_list.remove(passenger)
            print("Removed passenger from flight")
        else:
            print("Cannot remove, passenger not on flight list")

    def log_flight(self):
        with open("log.txt", 'at') as f:
            info = f"Flight Number: {self.flight_number}, Departure City: {self.departure_city}, Arrival City: {self.arrival_city}, Passenger Count: {len(self.passenger_list)}\n"
            f.write(info)
    
    def check_availability(self):
        return self.seat_capacity - len(self.passenger_list)
    
    def __str__(self):
        return f"Flight {self.flight_number} from {self.departure_city} to {self.arrival_city}"