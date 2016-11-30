/*
 * Holds Test methods for the recalculation of the next payment due date
 *
*/
@isTest (seeAllData = false)
private class Recalaulate_Next_Payment_Date_Test {
	
	@isTest static void test_Schedule() {
		Recalculate_Next_Payment_Date_Scheduled batch = new Recalculate_Next_Payment_Date_Scheduled();
		String sch = '0 0 * * * ?';
		system.schedule('Test Recalculation', sch, batch);
	}
	
	@isTest static void testBatchJob() {
		//Clears the date component of the soql query so that the batch job will run on all records
		Travel_Group_Helper.setDateFilter('');

		//start 
		test.startTest();
		Recalculate_Next_Payment_Date_Batch batch = new Recalculate_Next_Payment_Date_Batch();
		database.executeBatch(batch,20);
		
		//stop test
		test.stopTest();
	}
	

	/**
	 * @description Setup test data for the whole class
	 **/
	@testSetup static void setupData() {
		list<Account> acc 				= Test_Data_Factory.createAccount(1);
		List<Opportunity> opp 			= Test_Data_Factory.createOpportunity(1, acc[0]);
		List<Travel_Group__c> TG 		= Test_Data_Factory.createTravelGroups(1, opp[0]);
		List<Payment_Schedule__c> PS 	= Test_Data_Factory.createPaymentSchedule(1, TG[0]);
	}
}