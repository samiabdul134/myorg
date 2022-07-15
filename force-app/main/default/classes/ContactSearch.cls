public class ContactSearch {
public static List<Contact> searchForContacts(String LastName,String MailingAdd) {
 
List<Contact> Con=[Select id,Name from Contact where LastName=:LastName and MailingPostalCode=:MailingAdd];
Return Con;
}
}