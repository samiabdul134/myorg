global class SendEmailCls
{
    public static Boolean check=false;
    
    
    @Future(callout=true)     
    public static void EmailPDF(String RecordId,string EmailSbuject, string emailbody,string emailTo,string email1, set<id> AttachID)
    {   
        Account Acc= [Select id,name from Account where id=: RecordId];
        
        
        string EmailToValue = emailTo.replace(';',',');
        string[] lstMailTo = EmailToValue.split(',');
        string Email = emailTo; 
            
            Blob body1; 
            try 
            {
                
            }
            catch (VisualforceException e) 
            {
                body1 = Blob.valueOf('Some Text');
                system.debug(body1);
            }  
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setWhatId(RecordId);
            mail.setToAddresses(lstMailTo);//new String[] { Email}
            if(email1 != null && email1 != '')
            {
                string CCValue = email1.replace(';',',');
                string[] lstCC = CCValue.split(',');
                mail.setCcAddresses(lstCC);
            }
            mail.setSubject(EmailSbuject);
            mail.setHtmlBody(emailbody);
            emailbody=emailbody+'<br>Please click here to sign'+'<br>https://myats-developer-edition.ap4.force.com/signpad?param1='+Acc.id; 
            
            PageReference pdf;
            
            pdf= Page.AccountPDF;
            pdf.getParameters().put('id',Acc.id);
            mail.setHtmlBody(emailbody);
            
            
            // create the new attachment
            Attachment attach = new Attachment();
            attach.ContentType='application/pdf';
            Blob body;
            
            try 
            {
                // returns the output of the page as a PDF
                body = pdf.getContent();   
                // need to pass unit test -- current bug    
            } catch (VisualforceException e) 
            {
                body = Blob.valueOf('Some Text');
            }
            
            attach.Body = body;
            attach.Name ='AccountPDF'+'.pdf';
            
            attach.IsPrivate = false;
            attach.ParentId = RecordId;
           /*
            ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
            cVersion.PathOnClient = attach.Name;//File name with extention
            cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
            //cVersion.OwnerId = attach.OwnerId;//Owner of the file
            cVersion.Title = attach.Name;//Name of the file
            cVersion.VersionData = attach.Body;//File content
            Insert cVersion;
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cVersion.Id].ContentDocumentId;
            cdl.LinkedEntityId = RecordId;
            cdl.ShareType = 'I';
            //cdl.Visibility = 'InternalUsers';
            insert cdl;    
            
            Messaging.Emailfileattachment ef = new Messaging.Emailfileattachment();
            
            ef.setFileName(cVersion.Title);
            
            
            ef.setBody(cVersion.VersionData);
            fileAttachments.add(ef);
            */
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            for (ContentVersion a : [SELECT Title,VersionData,FileType FROM ContentVersion WHERE id in: AttachID])
            {
                Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                system.debug('Debug::FileType'+a.FileType);
                
                if(a.FileType == 'JPG')
                {
                efa.setFileName(a.Title+'.JPG');
                }
                else if(a.FileType == 'PNG')
                {
                efa.setFileName(a.Title+'.PNG');
                }
                else
                {
                efa.setFileName(a.Title);
                }
                
                efa.setBody(a.VersionData);
                fileAttachments.add(efa);
            }

            mail.setFileAttachments(fileAttachments);
            /*****************************/
            
            system.debug(mail); 
            Messaging.SendEmailResult[] mailResult = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            
        }
       
  
    
}