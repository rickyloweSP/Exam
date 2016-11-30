/*
 * Holds methods for creating test data
 *
*/
@isTest
public with sharing class Test_Data_Factory {

	/**
	 * @description create and insert Account
	 * @param numberToCreate - integer - for bulk testing
	 * @return list of the Accounts inserted
	 **/
	public static List<Account> createAccount(integer numberToCreate){

		List<Account> AccList = new List<Account>();

		for(Integer i = 0; i < numberToCreate; i++) {
			Account Acc = new Account();
			Acc.name = string.valueOf(i);
			AccList.add(Acc);
		}
		
		insert AccList;
		return AccList;
	}

	/**
	 * @description create and insert Opportunity
	 * @param numberToCreate - integer - for bulk testing
	 * @param Account Acc - The parent Account
	 * @return list of the Opportunities inserted
	 **/
	public static List<Opportunity> createOpportunity(integer numberToCreate, Account Acc){

		List<Opportunity> OppList = new List<Opportunity>();

		for(Integer i = 0; i < numberToCreate; i++) {
			Opportunity Opp 	= new Opportunity();
			Opp.name = Acc.name + ' ' + i;
			Opp.CloseDate = date.today();
			Opp.StageName = '1 - New Opportunity';
			OppList.add(Opp);
		}
		
		insert OppList;
		return OppList;
	}


	/**
	 * @description create and insert Travel Group
	 * @param numberToCreate - integer - for bulk testing
	 * @param Opportunity Opp - The parent opportunity
	 * @return list of the Travel Groups inserted
	 **/
	public static List<Travel_Group__c> createTravelGroups(integer numberToCreate, Opportunity Opp){

		List<Travel_Group__c> TGList = new List<Travel_Group__c>();

		for(Integer i = 0; i < numberToCreate; i++) {
			Travel_Group__c TG 	= new Travel_Group__c();
			TG.Opportunity__c = Opp.ID;
			TGList.add(TG);
		}
		
		insert TGList;
		return TGList;
	}

	/**
	 * @description create and insert Payment Schedules
	 * @param numberToCreate - integer - for bulk testing
	 * @param Travel_Group__c TG - The parent Travel Group
	 * @return list of the Payment Schedules inserted
	 **/
	public static List<Payment_Schedule__c> createPaymentSchedule(integer numberToCreate, Travel_Group__c TG){

		List<Payment_Schedule__c> PaymentList = new List<Payment_Schedule__c>();

		for(Integer i = 0; i < numberToCreate; i++) {
			Payment_Schedule__c PS 	= new Payment_Schedule__c();
			PS.Travel_Group__c	= TG.ID;
			PS.Due_Date__c	= date.today();
			PaymentList.add(PS);
		}
		
		insert PaymentList;
		return PaymentList;
	}

}