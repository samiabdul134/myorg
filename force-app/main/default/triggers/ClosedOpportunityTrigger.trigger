trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) 
{
  List<Task> LstofTask=new List<Task>();
  for(Opportunity Opp : trigger.new)
    {
      if(Opp.StageName=='Closed Won')
        {
          Task T=new Task();
          T.whatId=Opp.id;
          T.Subject='Follow Up Test Task';
          LstofTask.add(T);
        }
    } 
 Insert LstofTask;
}