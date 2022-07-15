public with sharing class GetAccounts{

public list<Account> LstOfAccount{get;set;}
public GetAccounts(Apexpages.StandardController Std)
{
   LstOfAccount=new List<Account>([Select id,Name from Account]);
   
}
}