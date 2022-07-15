public class SendEmail{

    
    public Account Acc{get;set;}
    private Integer serialNo=0;   
    public boolean Check {get; set;}
    public boolean AttachCheck {get; set;}
    public string PCEmail {get; set;}
    public String emailTo {get; set;}
    public String emailTo1{get; set;}
    public String emailBody {get; set;}
    public String emailSubject{get; set;}
    public String response {get; set;}
    public string SID;
    public boolean blockflag{get;set;}
    public user currentuser{get;set;}
    public Account AProject{get;set;}
    public list <Account> LstProject {get; set;}
    public list<ContentVersion> LstOfAttach {get; set;}
    public list<ContentVersion> LstOfAttachment {get; set;}
    public boolean flag{get;set;}
    public List<string> attach{get; set;}
    public list<AttachmentWrapper> AttachmentWrap{get; Set;}
    public list<AttachmentWrapper> AttachmentWrapp{get; Set;}
    public list<ContentDocumentLink> LstOfCDL {get; set;}
    public set<id> setofPrentIDs=new set<id>();
    public SendEmail(ApexPages.StandardController controller)
    {
        SID = apexpages.currentpage().getparameters().get('id');
        system.debug('SID='+SID);
        
        //AQuote= (FConnect__Service_Quote__c)controller.getrecord();
        flag =false;
        LstOfCDL =[Select id,ContentDocumentId, ContentDocument.LatestPublishedVersionId from ContentDocumentLink where LinkedEntityId =: SID];
        for(ContentDocumentLink C : LstOfCDL)
        {
        setofPrentIDs.add(C.ContentDocumentId);
        }
        //  List Add to Wrapper
        boolean check =false;  
        AttachmentWrap =new list<AttachmentWrapper>();
        LstOfAttach = [select id,Title,ContentDocumentId from ContentVersion where ContentDocumentId in:setofPrentIDs];//AND Name != 'Customer Signature' AND Name != 'Technician Signature'
        for(ContentVersion atch :LstOfAttach)
        {
            AttachmentWrap.add(new AttachmentWrapper(atch,check));
             blockflag=true;
        }
        Acc= [Select id,Name,Email_Rich_Text__c from Account where id =: SID];
        boolean attachcheck =false;  
        AttachmentWrapp =new list<AttachmentWrapper>(); 
        LstOfAttachment  = [select id,Title,ContentDocumentId from ContentVersion where ContentDocumentId in:setofPrentIDs];// where ParentId =:SID
        for(ContentVersion attach :LstOfAttachment)
        {
            AttachmentWrapp.add(new AttachmentWrapper(attach,attachcheck));
        }  
      if(Acc != null)
       {
        currentuser=new User();
        currentuser=[Select Id,Name,Email from User where Id=:userinfo.getuserId()];
        emailTo = '';
        emailTo1 = null;
        emailSubject=Acc.Name;
        Acc.Email_Rich_Text__c = '<html><body>Attached is the information that you requested.<br>Please do not hesitate to call if you have any questions or if I can be of further assistance to you.<br><br><br>Thank you!';
        
       
       }
       
       
    }
    public PageReference sendEmail()
    { 
        
        string emailbody1;
        string SOid = Acc.id;
        emailbody1= Acc.Email_Rich_Text__c;
        System.Debug('Email Body'+Acc.Email_Rich_Text__c);
        Update Acc;
        set<id> SetOfAttachID = new set<id>();
        set<id> SetOfFileID = new set<id>();
        
        for(AttachmentWrapper  Attwrapper : AttachmentWrap)
        {
            if(Attwrapper.check == true)
            {
                SetOfAttachID.add(Attwrapper.attached.id);
            }
        }
       
        for(AttachmentWrapper  Attwrapp : AttachmentWrapp)
        {
            if(Attwrapp.attachcheck == true)
            {
                SetOfAttachID.add(Attwrapp.attached.id);
            }
        }
       
        PageReference pf = new pagereference('/'+SOid);
        system.debug('Debug::185'+emailTo1);
        if(emailTo != '' && Acc != null)
        {
            SendEmailCls.EmailPDF(SOid,emailSubject,emailbody1,emailTo,emailTo1,SetOfAttachID);
        }
       
        return pf;
    }
    public PageReference Cancel() 
    {     
        PageReference pf1 = new pagereference('/'+SID);
        return pf1;  
    }
    // Wrapper Class 
    public class AttachmentWrapper
    {
        public boolean check {get; set;}
        public ContentVersion attached{get; private set;}
        public boolean AttachCheck {get; set;}
        
        // Argumental Constructor
        public AttachmentWrapper(ContentVersion attached,boolean Check)
        {
            this.check = check;
            this.AttachCheck = AttachCheck ;
            this.attached= attached;
            
        }
    }
}