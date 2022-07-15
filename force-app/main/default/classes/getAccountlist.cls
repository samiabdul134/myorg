public class getAccountlist{

@AuraEnabled(cacheable=true)
public static List<Account> GetAccounts()
{
    List<Account> LstOfAcc=[Select id,Name from Account where Name like '%Test%'];
    Return LstOfAcc;
}
}