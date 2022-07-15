@IsTest
public class PostDataByJSonTest_Class {
  
static TestMethod void MyUnitTest()
{
    Account Acc=new Account(Name='Sami');
    Insert Acc;
    String jsonInput ='{\n' +
    ' "SFID" : "0016F000032dymA",\n' +
    ' "Phone" : "03432494077"'+
    '}';
    String JS=JSON.Serialize(Acc);
    System.debug(JS);
    PostDataByJSON.PostJsonMethod(jsonInput);
    
}
}