@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager{
@HttpGet
global static Account getAccount()
{
 RestRequest Req=RestContext.request;
 
 String RecordId=Req.requestUri.subString(Req.requestURI.lastIndexOf('/')+1);
 Account Acc=[Select id,Name,(Select id,Name from Contacts) from Account where id=:RecordId];
 
 return Acc;
}

}