//calls form validators
$(document).ready(function(){
  validateLength(nameInput);
  validateFormat(emailInput);
  validateLength(passwordInput);
  validateMatch(passwordConfirmation);
})

// input blueprint
function input(id, error, requiredLength){
  this.id = id;
  this.errorMessage = error;
  this.requiredLength = requiredLength 
}

//signing up
var email = new input('#email', 
  "Incorrect password",  null);

var password = new input('#Password', 
  'Password must be at least 5 characters long', 5);

//logging in
var passwordConfirmation = new input('#user_password_confirmation', 
  'Passwords do not match', 5);

var nameInput = new input('#inputName',  
  'Name must be at 3 least characters long', 3);

var emailInput= new input('#inputEmail',
  "That doesn't appear to be a valid email address", 5);

var passwordInput = new input('#inputPassword',  
  'Password must be at least 5 characters long', 5);

var validateLength = function(el){
  $(el.id).keyup(function(){
    if ($(el.id).val().length < el.requiredLength){
      $(el.id).prev().css('color', '#cf4343')
      $(el.id).prev().html(el.errorMessage);
      console.log(el.requiredLength)
    }else{
      $(el.id).prev().html('');
      if (el.id === '#inputPassword' ){
        validateMatch(password)
      }
    }
  });
}

var validateMatch = function(el){
  $(el.id).keyup(function(){
    p = $('#inputPassword').val()
    if ($(el.id).val() != p){
      $(el.id).prev().css('color', '#cf4343')
      $(el.id).prev().html(el.errorMessage);
    }else{
      $(el.id).prev().html('');
    }
  });
}

var validateFormat = function(el){
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  $(el.id).keyup(function(){
    if (!$(el.id).val().match(re)){
      $(el.id).prev().css('color', '#cf4343')
      $(el.id).prev().html(el.errorMessage);
    }else{
      $(el.id).prev().html('');
    }
  });
}

