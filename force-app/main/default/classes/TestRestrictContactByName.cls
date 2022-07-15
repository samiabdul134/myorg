@IsTest
Public class TestRestrictContactByName{
public static testmethod void MyUnitTest()
{
  Contact Con=new Contact(FirstName='Abdul',LastName='Sami');
  Insert Con;
  Con.LastName='INVALIDNAME';
  Update Con;
}
}