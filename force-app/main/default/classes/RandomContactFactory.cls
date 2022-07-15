Public class RandomContactFactory{
Public static List<Contact> generateRandomContacts(Integer Count, String LastName)
{
List<Contact> LstOfCon=new List<Contact>();
Contact Con;
for(Integer i=0; i< Count; i++){
Con=new Contact(FirstName=String.valueOf(i),LastName=LastName);
LstOfCon.add(Con);
}
Return LstOfCon;
}
}