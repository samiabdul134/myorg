({
myAction : function(component, event) {
        var i=component.get("v.recordId");
        
		var action = component.get("c.getContacts");
        action.setParams({
            "AccountId" : i
        });
        
        action.setCallback(this, function(a) {
            var Status=a.getState();
            var ResValue = a.getReturnValue();
            if(Status=='SUCCESS' && a.getReturnValue() != null)
            {
             component.set("v.contacts",a.getReturnValue());   
            }
             
         });
         $A.enqueueAction(action);
	}
})