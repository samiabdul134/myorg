trigger AccountAddressTrigger on Account (Before insert,before update) 
{
  for(Account Acc : Trigger.new)
  {
   if(Acc.Match_Billing_Address__c == true)
    {
      Acc.ShippingPostalCode=Acc.BillingPostalCode;
    }
  }  
}