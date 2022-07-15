public with sharing class ContactList {
@auraEnabled
    public Static List<Contact> getContacts(String AccountId)
    {
        System.debug('Debug::AccountId'+AccountId);
        List<Contact> LstOfContact=[Select id,Name from Contact where AccountId =: AccountId];
        Return LstOfContact;
    }
}