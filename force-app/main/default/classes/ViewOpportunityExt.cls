public with sharing class ViewOpportunityExt {
@AuraEnabled
    public Static List<Opportunity> getOpportunities()
    {
        List<Opportunity> LstOfOpportunity=new List<Opportunity>([Select id,Name from Opportunity]);
        
        Return LstOfOpportunity;
    }
}