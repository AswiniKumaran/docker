getElementById("myForm").onsubmit = function(event){
    event.preventDefault();
    alert("Note added successfully.");
    this.submit();
}