function Item(data) {
    this.name = ko.observable(data.name);
    this.quantity = ko.observable(data.quantity);
    this.description = ko.observable(data.description);
    this.id = ko.observable(data.id);
    this.guestCreated = ko.observable(data.allow_guest_create);
    this.amountPromised = ko.observable(data.quantity_promised);
}

function Event(data) {
    var self = this;
    self.id = ko.observable(data.id)
    self.name = ko.observable(data.name);
    self.description = ko.observable(data.description);
    self.date = ko.observable(data.date);
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
    self.image = ko.observable(data.image);
    self.backgroundImage = ko.computed(function() {
        return { "backgroundImage": 'url(' + self.image() + ')' };
    }, self); 

    self.items = ko.observableArray([]);


    self.addItems = function(itemsArray){
        for (var i = 0; i < itemsArray.length; i++){
            self.items.push(new Item(itemsArray[i]));
        }
    }
};

function MasterVM() {
    var self = this;    
    self.newItemName = ko.observable();
    self.items = ko.observableArray([]);
    self.events = ko.observableArray([]);
    self.currentEvent = ko.observable();

    self.editingText = ko.observable(true);
    self.addEvent = function(data) { self.events.push(new Event(data));};
    self.removeEvent = function(event) { self.events.remove(event) }

    self.removeItem = function(item) { self.items.destroy(item);};


    self.save = function(data) {
        $.ajax("/events", {
            data: ko.toJSON({ event: self }),
            type: "post", contentType: "application/json",
            success: function(result) { console.log("+++") }
        });
    }

    self.submitPhoto = function(data){
        $('#upload_pic').click(function() {
            $("#form_id").ajaxForm().submit(); 
            $('#imageUpload').foundation('reveal', 'close');
            self.refreshPhoto();
            return false;
        });
    }

    self.refreshPhoto = function(){
        $.ajax("/events/", {
            data: { id: $('.id').text() },
            type: "get", contentType: "application/json",
            success: function(result) { 
                $('.background').css("background-image","url("+result.image+")");
            }
        });
    }

    self.toggleEdit = function() {
        console.log("hello world")
        if (self.editingText() == false){
            self.editingText(true);
            $("a#editToggle").text('Save')

        }else{
            self.editingText(false);
            $("a#editToggle").text('Edit')
            self.save(self.currentEvent());
        }
    }

    self.getEvent = function(data) {
        $.ajax("/events/", {
            data: { id: $('.id').text() },
            type: "get", contentType: "application/json",
            success: function(result) { 
                self.currentEvent(new Event(result));
                self.currentEvent().addItems(result.items);
            }
        });
    }
    self.getEvent();
}




