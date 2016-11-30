/*
 * Holds Generic methods for the Travel Group object
 *
*/
public class Travel_Group_Helper {
	

	/**
	 * @description - singleton for setting the date part of the filter. Used so that the test method can clear the date part
	 **/
	private static String dateFilter;                            
	private static String getDateFilter() {
	    return dateFilter == null ? 'Next_Payment_Due_Date__c <= TODAY' : dateFilter;
	}
	@TestVisible
	private static void setDateFilter(String dateFilterNew) {
	    dateFilter = dateFilterNew;
	}


	/**
	 * @description - generate the query for getting Travel Groups with a next payment date in the past
	 * @param - none
	 * @return String - The query
	 **/
    public static string getTGNextPaymentDatePast(){
        list<string> fields = new String[]{'ID','Next_Payment_Due_Date__c'};
        string whereClause = getDateFilter();

        //Return the query
        return Helper_Class.buildSOQL(fields, 'Travel_Group__c', whereClause,'Next_Payment_Due_Date__c');
    }
	

	/**
	 * @description - clear the Next Payment Date
	 * @param list<Travel_Group__c> TG - the travel groups
	 * @return list<Travel_Group__c> - The travel groups with the next payment date set to null
	 **/
    public static list<Travel_Group__c> clearTheNextPaymentDate(list<Travel_Group__c> TGs){
    	for(Travel_Group__c TG : TGs){
    		clearTheNextPaymentDate(TG);
    	}
    	return TGs;
    }


	/**
	 * @description - clear the Next Payment Date
	 * @param Travel_Group__c TG - the travel group
	 * @return Travel_Group__c - The travel group with the next payment date set to null
	 **/
    public static Travel_Group__c clearTheNextPaymentDate(Travel_Group__c TG){
    	TG.Next_Payment_Due_Date__c = null;
    	return TG;
    }

}