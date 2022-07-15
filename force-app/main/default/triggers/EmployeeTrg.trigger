trigger EmployeeTrg on Employee__c (after insert,after update,after delete)
{   
    set<id> SetOfCompanyIds;
    if((Trigger.IsInsert || Trigger.IsUpdate || Trigger.IsDelete) && Trigger.IsAfter)
    {
     if(Trigger.IsDelete)
     {
        SetOfCompanyIds=new set<id>();
        for(Employee__c Emp : Trigger.old)
        {
          SetOfCompanyIds.add(Emp.Company__c);
        }
        CalculateAvgClass AvgCls=new CalculateAvgClass();
        AvgCls.CalculateAvg(SetOfCompanyIds);      
     }
     else
     {
      SetOfCompanyIds=new set<id>();
      for(Employee__c Emp : Trigger.new)
      {
        SetOfCompanyIds.add(Emp.Company__c);
      }
      CalculateAvgClass AvgCls=new CalculateAvgClass();
      AvgCls.CalculateAvg(SetOfCompanyIds);
     }
    }
}