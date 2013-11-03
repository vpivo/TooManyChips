$(document).ready(function(){
  validateLength(nameInput);
  validateFormat(email);
  validateLength(password);
  validateMatch(passwordConfirmation);
})

function input(id, error, requiredLength){
  this.id = id;
  this.errorMessage = error;
  this.requiredLength = requiredLength 
}

//signing up
var email = new input('#inputEmail',
  "That doesn't appear to be a valid email address.", 5);

var password = new input('#inputPassword', 
  'Password must be at least 5 characters long.', 5);

var passwordConfirmation = new input('#user_password_confirmation', 
  'Passwords do not match', 5);

var nameInput = new input('#inputName',  
  'Name must be at 3 least characters long.', 3);

//logging in
var emailTag = new input('#email', 
  "Incorrect password.", 5, null);

var passwordTag = new input('#password',  
  'Incorrect password.', 5, null);

var validateLength = function(el){
  $(el.id).keyup(function(){
    if ($(el.id).val().length < el.requiredLength){
      $(el.id).prev().html(el.errorMessage);
    }else{
      $(el.id).prev().html('');
    }
  });
}

var validateMatch = function(el){
  $(el.id).keyup(function(){
    if ($(el.id).val() != ($('#password').val())){
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
      $(el.id).prev().html(el.errorMessage);
    }else{
      $(el.id).prev().html('');
    }
  });
}

