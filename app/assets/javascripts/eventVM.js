function EditableText(text, editable) {
    var self = this;
    self.text = ko.observable(text);
    self.editing = ko.observable(false);
}

function Item(data) {
    this.name = ko.observable(data.name);
    this.quantity = ko.observable(data.quantity);
    this.description = ko.observable(data.description);
    this.id = ko.observable(data.id);
    this.guestCreated = ko.observable(data.allow_guest_create);
    this.guestAmount = ko.observable(data.user_quanity);
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

    self.items = ko.observableArray([]);

    self.edit = function(model) {
        model.editing(true);
    }

    self.addItems = function(itemsArray){
        for (var i = 0; i < itemsArray.length; i++){
            self.items.push(itemsArray[i]);
        }
    }
};



    //Master View
    function MasterVM() {
        var self = this;    
        self.newItemName = ko.observable();
        self.items = ko.observableArray([]);
        self.events = ko.observableArray([]);
        self.currentEvent = ko.observable();

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

        self.getEvent = function(data) {
            $.ajax("/events/", {
                data: { id: $('.id').text() },
                type: "get", contentType: "application/json",
                success: function(result) { 
                    self.currentEvent(new Event(result));
                    self.currentEvent().addItems(result.items);
                    console.log(result.items[0])

                }
            });
        }
        self.getEvent();
    }




