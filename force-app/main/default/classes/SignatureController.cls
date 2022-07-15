public without sharing class SignatureController 
{
    public Account Acc{get;set;}
    
    
    public SignatureController(ApexPages.StandardController controller) 
    {
      Acc= (Account)controller.getRecord();
      system.debug('Debug::'+Acc);
    }
    
    @RemoteAction
    public static PageReference saveSignature(String signatureBody, String sid,String sname) 
   {
   // try
  // {
    String id='0016F00003TUCzT';
    Account O = [select id,name,DocumentId__c from Account where id=:id];
    //List<sObject> O= Database.query('select id,name,DocumentId__c from Account where id=:id');
    // Creating a new Document //Signature_Name__c
    
    document newDoc = new document();
    newDoc.name = O.name;
    newDoc.authorid=UserInfo.getUserId();
    newDoc.FolderId =UserInfo.getUserId() ; // to get the personal document folder ID
    newDoc.Body = EncodingUtil.base64Decode(signatureBody);
    newDoc.type = 'image/png';
    insert newDoc ;
    
    if(newDoc.id!=null)
    {
       O.DocumentId__c = newDoc.id;
       update O;
    } 
    PageReference pg=new PageReference('https://samidomain-dev-ed--c.ap4.visual.force.com/apex/SignSuccessMessage');
    
    return pg;
  /* }
      catch(Exception e)
      {
       return JSON.serialize(e);
       }
    */
   }
    public pagereference goToviewPage()
    {
      pagereference pageref;
      return pageref;
    }
    
}