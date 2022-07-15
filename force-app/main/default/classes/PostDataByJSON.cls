@RestResource(urlMapping='/PostDataByJSON/PostJsonMethod/')
global with sharing class PostDataByJSON
{
   Public class DeserialzedItems{
   public String SFID{get;set;}
   public String Phone{get;set;}
   }
   @HttpPut
   global static void PostJsonMethod(String JS)
   {
     system.debug('Debug::7'+JS);
     Map<String, Object> MapDOfJSon = (Map<String, Object>)JSON.deserializeUntyped(JS);
     //List<DeserialzedItems> LstAccount=(List<DeserialzedItems>)JSON.Deserialize(JS,List<DeserialzedItems>.class);
     system.debug('Debug::15'+MapDOfJSon.values());
     
     
   }
}