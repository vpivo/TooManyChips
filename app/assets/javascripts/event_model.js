// Class to represent a row in the seat reservations grid
// function Event(title, description, date, location, state, city, zip, allow_guest_create, host_name, street_address, start_time, end_time, event_type) {
//     var self = this;
//     self.name = name;
//     self.meal = ko.observable(initialMeal);

//     self.formattedPrice = ko.computed(function() {
//         var price = self.meal().price;
//         return price ? "$" + price.toFixed(2) : "None";        
//     });    
// }


function EventVM() {
    // Data
    var self = this;
    self.title = ko.observable();
    self.description = ko.observable();
    self.date = ko.observable();
    self.location = ko.observable();
    self.state = ko.observable();
    self.city = ko.observable();
    self.zip = ko.observable();
    self.allow_guest_create = ko.observable();
    self.host_name = ko.observable();
    self.street_address = ko.observable();
    self.start_time = ko.observable();
    self.end_time = ko.observable();
    self.event_type = ko.observable();

    self.save = function(data) {
        console.log(data)
        console.log(ko.toJSON({ event: data }))
        $.ajax("/events", {
            data: ko.toJSON({ event: self }),
            type: "post", contentType: "application/json",
            success: function(result) { alert("done") }
        });
    };


}



