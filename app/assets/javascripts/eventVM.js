// Class to represent a row in the seat reservations grid
// function Event(title, description, date, location, state, city, zip, allow_guest_create, host_name, street_address, start_time, end_time, event_type) {

    function Item(data) {
        this.name = ko.observable(data.name);
        this.isDone = ko.observable(data.isDone);
    }


    function Event(data) {
        var self = this;
        self.name = ko.observable(data.name);
        self.description = ko.observable(data.description);
        self.date = ko.observable(date.date);
        self.location = ko.observable(data.location);
        self.state = ko.observable(data.state);
        self.city = ko.observable(data.city);
        self.zip = ko.observable(data.zip);
        self.allow_guest_create = ko.observable(data.allow_guest_create);
        self.host_name = ko.observable(data.host_name);
        self.street_address = ko.observable(data.street_address);
        self.start_time = ko.observable(data.start_time);
        self.end_time = ko.observable(data.end_time);
        self.event_type = ko.observable(data.event_type);
        self.items = ko.observableArray(data.items);
    }


//ajax call




function MasterVM() {
    var self = this;
    var self = this;
    
    //Event placeholders
    self.name = ko.observable("tomorrow");
    self.description = ko.observable("tomorrow");
    self.date = ko.observable("tomorrow");
    self.location = ko.observable("tomorrow");
    self.state = ko.observable("tomorrow");
    self.city = ko.observable("tomorrow");
    self.zip = ko.observable("tomorrow");
    self.allow_guest_create = ko.observable("tomorrow");
    self.host_name = ko.observable("tomorrow");
    self.street_address = ko.observable("tomorrow");
    self.start_time = ko.observable("tomorrow");
    self.end_time = ko.observable("tomorrow");
    self.event_type = ko.observable("tomorrow");
    

    //Item placeholders
    self.newItemName = ko.observable();

    //relationship objects

    self.items = ko.observableArray([
        ]);

    self.events = ko.observableArray([
        ]);

    self.addEvent = function(data) {
        console.log('hello')
        self.events.push(new Event(data));
    }

    self.removeEvent = function(event) { self.events.remove(event) }

    self.addItem = function() {
        self.items.push(new Item({ name: self.newItemName() }));
        self.newItemName("");
    };

    self.removeItem = function(item) { 
        console.log('hello')
        console.log(item);
        self.items.destroy(item);
    };

    self.save = function(data) {
        console.log(ko.toJSON({ event: self }))
        $.ajax("/events", {
            data: ko.toJSON({ event: self }),
            type: "post", contentType: "application/json",
            success: function(result) { console.log(result) }
        });
    }
}




