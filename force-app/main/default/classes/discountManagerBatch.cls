public class discountManagerBatch implements Database.Batchable<sObject> { 

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id FROM PricebookEntry WHERE isActive = true AND EndDate__c < TODAY');
     }   

    public void execute(Database.BatchableContext info, List<PricebookEntry> scope){
        List<PricebookEntry> pricebookEntriesToUpdate = new List<PricebookEntry>();
        Datetime dateToCompare = system.today();

        for(PricebookEntry pbe : scope){
            pbe.isActive = false;
            pricebookEntriesToUpdate.add(pbe); 
            }
         

        update pricebookEntriesToUpdate;
    
    }     

    public void finish(Database.BatchableContext info){   

        } 
 }