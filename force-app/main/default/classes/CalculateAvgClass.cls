public class CalculateAvgClass{

 List<AggregateResult> LstToGetAvg{get;set;}
 public void CalculateAvg(Set<id> SetOfCompanyIds)
  {
     LstToGetAvg=[Select Company__c Com,AVG(Salary__c)avg from Employee__c where Company__c in : SetOfCompanyIds group by Company__c];
     List<Company__c> LstOfCompany=[Select id,Average_Salaries__c from Company__c where id in:SetOfCompanyIds];
     system.debug('Debug::8'+LstToGetAvg);
     for(AggregateResult AR : LstToGetAvg)
     {
       for(Company__c Comp : LstOfCompany)
       {
        if(AR.get('Com') == Comp.id)
        {
        Comp.Average_Salaries__c = (Decimal) AR.get('avg');       
        } 
       } 
     }
     update LstOfCompany;
  }
}