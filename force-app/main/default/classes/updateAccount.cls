public class updateAccount{

    public Static string UpdateAccountDetail(String actDetails) {
        HttpRequest req = new HttpRequest();

        req.setMethod('PUT');
        String url='https://ap4.salesforce.com/services/apexrest/PostDataByJSON/PostJsonMethod/';
        string endpoint = url;
        system.debug('endpoint = ' + endpoint);
        req.setEndpoint(endpoint);
       

        req.setBody(actDetails);
        req.setCompressed(true); 
        //req.setHeader('Authorization', 'OAuth '+ oauth.access_token);
        req.setHeader('content-type', 'application/json');

        Http http = new Http();

        HTTPResponse res = http.send(req);

        System.debug('BODY: '+res.getBody());

        System.debug('STATUS:'+res.getStatus());

        System.debug('STATUS_CODE:'+res.getStatusCode());

        return res.getBody();

    }
}