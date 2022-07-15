public class CreateAccountsAndContacts{

@AuraEnabled
public static List<Contact> GetContacts(Id AccountId){

List<Contact> LstOfContacts=[Select id,Name,AccountId from Contact where AccountId=:AccountId];
Return LstOfContacts;
}
@AuraEnabled
public static void RemoveRow(String Index){
    
}
@AuraEnabled
public static void AddRow(){
    
}
@AuraEnabled
public static void SaveAccountAndContacts(){
    
}
}