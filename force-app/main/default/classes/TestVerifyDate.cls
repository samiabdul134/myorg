@IsTest
public class TestVerifyDate{
public Static TestMethod void TestVerifyDateMethod()
{
 VerifyDate D=new VerifyDate();
 DateTime dt=System.now();
 VerifyDate.CheckDates(dt.Date(),dt.Date());
 VerifyDate.CheckDates(dt.Date()+30,dt.Date());
 
 
} 
}