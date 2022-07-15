public with sharing class CreateWorkOrderCls {
@AuraEnabled
    public static Work_Order__c CreateRecord(Work_Order__c WOrder)
    {
        System.debug('Debug::WOrder'+WOrder);
        Insert WOrder;
        System.Debug('WOrder'+WOrder);
        return WOrder;
    }
}