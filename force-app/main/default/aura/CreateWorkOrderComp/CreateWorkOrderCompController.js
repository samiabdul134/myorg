({

create : function(component, event) {
//getting the staff information
var WO = component.get("v.WorkOrder");
alert('WO'+WO.Name);
//Make field required from front end (Not from DB)
if(WO.Name=''){
alert('Missing name');
return false;
}

//Calling the Apex Function
var action = component.get("c.CreateRecord");

//Setting the Apex Parameter
action.setParams({
"WOrder" : WO
});

//Setting the Callback
action.setCallback(this,function(response){
//get the response state
var state = response.getState();
//check if result is successfull
if(state == "SUCCESS"){
//Reset Form
var newWO = {'sobjectType': 'Work_Order__c','Name':'','Description__c':'','Status__c':'','Account__c':'','Contact__c':''};
//Resetting the Values in the form
component.set("v.WorkOrder",newWO);

alert('Record is Created Sucessfully');

var urlEvent = $A.get("e.force:navigateToURL");
urlEvent.setParams({
"url":"/lightning/o/Work_Order__c/list?filterName=Recent&0.source=alohaHeader"
});
console.log(urlEvent);
urlEvent.fire();

} else if(state == "ERROR"){
//errors coming from DB thrown by controler catch blocl
let errors = response.getError();
let message;
// Retrieve the error message sent by the server
if (errors && Array.isArray(errors) && errors.length > 0) {
message = errors[0].message;
}

alert(message);
}
});
    
//adds the server-side action to the queue
$A.enqueueAction(action);

}
})