// Class to represent a row in the seat reservations grid
function SeatReservation(name, initialMeal) {
    var self = this;
    self.name = name;
    self.meal = ko.observable(initialMeal);

    self.formattedPrice = ko.computed(function() {
        var price = self.meal().price;
        return price ? "$" + price.toFixed(2) : "None";        
    });    
}

// Overall viewmodel for this screen, along with initial state
function ReservationsViewModel() {
    var self = this;

    // Non-editable catalog data - would come from the server
    self.availableMeals = [
        { mealName: "Standard (sandwich)", price: 0 },
        { mealName: "Premium (lobster)", price: 34.95 },
        { mealName: "Ultimate (whole zebra)", price: 290 }
    ];    

    // Editable data
    self.seats = ko.observableArray([
        new SeatReservation("Steve", self.availableMeals[0]),
        new SeatReservation("Bert", self.availableMeals[0])
    ]);

    // Computed data
    self.totalSurcharge = ko.computed(function() {
       var total = 0;
       for (var i = 0; i < self.seats().length; i++)
           total += self.seats()[i].meal().price;
       return total;
    });    

    // Operations
    self.addSeat = function() {
        self.seats.push(new SeatReservation("", self.availableMeals[0]));
    }
    self.removeSeat = function(seat) { self.seats.remove(seat) }
}

    self.addTask = function() {
        self.tasks.push(new Task({ title: this.newTaskText() }));
        self.newTaskText("");
    };
    self.removeTask = function(task) { self.tasks.remove(task) };
    
    self.sayHello = function(){
      console.log("yays!");
  };

function Item(data) {
    this.title = ko.observable(data.title);
    this.isDone = ko.observable(data.isDone);
}

function EventVM(title, description) {
    // Data
    var self = this;
    self.title = ko.observable();
    self.description = ko.observable("");
    self.date = ko.observable("11/12/1983");
    self.location = ko.observable("");
    self.url = ko.observable("");
    self.user_id = ko.observable("");
    self.created_at = ko.observable("");
    self.updated_at = ko.observable("");
    self.image = ko.observable("");
    self.state = ko.observable("");
    self.city = ko.observable("");
    self.zip = ko.observable("");
    self.allow_guest_create = ko.observable("");
    self.host_name = ko.observable("");
    self.street_address = ko.observable("");
    self.start_time = ko.observable("");
    self.end_time = ko.observable("");
    self.event_type = ko.observable("");


    // Operations

}



