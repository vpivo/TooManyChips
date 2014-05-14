
function Item(data) {
    this.name = ko.observable(data.name);
    this.quantity = ko.observable(data.quantity);
    this.description = ko.observable(data.description);
    this.id = ko.observable(data.id);
    this.guest_created = ko.observable(data.allow_guest_create);
}

function Event(data) {
    var self = this;
    self.id = ko.observable(data.id)
    self.name = ko.observable(new EditableText(data.name, false));
    self.description = ko.observable(new EditableText(data.description, false));
    self.date = ko.observable(new EditableText(data.date, false));
    self.location = ko.observable(new EditableText(data.location, false));
    self.state = ko.observable(new EditableText(data.state, false));
    self.city = ko.observable(new EditableText(data.city, false));
    self.zip = ko.observable(new EditableText(data.zip, false));
    self.allow_guest_create = ko.observable(new EditableText(data.allow_guest_create, false));
    self.host_name = ko.observable(new EditableText(data.host_name, false));
    self.street_address = ko.observable(new EditableText(data.street_address, false));
    self.start_time = ko.observable(new EditableText(data.start_time, false));
    self.end_time = ko.observable(new EditableText(data.end_time, false));
    self.event_type = ko.observable(new EditableText(data.event_type, false));
    self.image = ko.observable(data.image);
    self.backgroundImage = ko.computed(function() {
        return { "backgroundImage": 'url(' + self.image() + ')' };
    }, self); 
    self.edit = function (model) {
        console.log(model.text())
        model.editing(true);
    };
}

function EditableText(text, editable) {
    var self = this;
    self.text = ko.observable(text);
    self.editing = ko.observable(false);
}

function MasterVM() {
    var self = this;    
    self.newItemName = ko.observable();
    self.items = ko.observableArray([]);
    self.events = ko.observableArray([]);
    self.currentEvent = ko.observable();

    self.addEvent = function(data) { self.events.push(new Event(data));};
    self.removeEvent = function(event) { self.events.remove(event) }

    self.addItem = function() {
        self.currentitems.push(new Item(data));
        self.newItemName("");
    };
    self.removeItem = function(item) { self.items.destroy(item);};

    self.save = function(data) {
        console.log(ko.toJSON({ event: self }))
        $.ajax("/events", {
            data: ko.toJSON({ event: self }),
            type: "post", contentType: "application/json",
            success: function(result) { console.log(result) }
        });
    }

    self.getEvent = function(data) {
        $.ajax("/events/", {
            data: { id: 50 },
            type: "get", contentType: "application/json",
            success: function(result) { 
                console.log(result)
                self.currentEvent(new Event(result));
                console.log(result.items[0])

            }
        });
    }
    self.getEvent();
}




