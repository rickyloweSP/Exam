/*
 * Updates the Travel group records with a next payment date in the past. 
 * Flow will then run to calculate the next payment date
 *
*/
global class Recalculate_Next_Payment_Date_Batch implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(Travel_Group_Helper.getTGNextPaymentDatePast());
   }
	
   global void execute(Database.BatchableContext BC, List<sObject> scope){
      //Clear the next payment date
      Travel_Group_Helper.clearTheNextPaymentDate( (list<Travel_Group__c>) scope);
      
      //Update the Travel Groups
      Helper_Class.databaseUpdateAllowFaillure(scope);
   }

   global void finish(Database.BatchableContext BC){
   }
}