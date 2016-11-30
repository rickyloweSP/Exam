/*
 * Holds Generic methods for all objects
 *
*/
public without sharing class Helper_Class {
    /**
	 * @description - generates a SOQL query a                                                                                                                                                                                                                                                                                                                                     ∑ 
	 * @param fields - a list of fields to be returned
	 * @param theObject - the API object name
	 * @param whereClause - the where clause
	 * @param orderBy - The field to order by
	 * @return String - The query
	 **/
    public static string buildSOQL(list<string> fields, string theObject, string whereClause, string orderBy){
        
        String placeholder = 'SELECT {0} FROM {1}';
        
        if(whereClause != null && whereClause != ''){
        	 placeholder += ' WHERE {2}';
        }

        if(orderBy != null && orderBy != ''){
        	placeholder += ' ORDER BY {3}';
        }

        string fieldsFormatted = string.join(fields,',');

		List<String> fillers = new String[]{fieldsFormatted,theObject,whereClause,orderBy};
		String query = String.format(placeholder, fillers);
        return query;
    }

	
	/**
	 * @description - Performs a Database.update with all or nothing set to false. Also prints to debug log                                                                                                                                                                                                                                                                                                                      ∑ 
	 * @param list<sobject> sobjs - list of the sobjects to update
	 **/
	public static void databaseUpdateAllowFaillure(list<sobject> sobjs){
		saveResult(Database.update(sobjs, false));
	}


    /**
	 * @description - prints a database.update/database.insert to the debug log                                                                                                                                                                                                                                                                                                                          ∑ 
	 * @param saveResult (see databaseUpdateAllowFaillure method on how to use)
	 **/
    public static void saveResult(Database.SaveResult[] saveResult){
		// Iterate through each returned result
		for (Database.SaveResult sr : saveResult) {
			if (sr.isSuccess()) {
				// Operation was successful, so get the ID of the record that was processed
				System.debug('Successfully Inserted/Updated object. object Id: ' + sr.getId());
			}
			else {
				// Operation failed, so get all errors
				for(Database.Error err : sr.getErrors()) {
					System.debug('The following error has occurred for record');
					System.debug(err.getStatusCode() + ': ' + err.getMessage());
					System.debug('object fields that affected this error: ' + err.getFields());
				}
			}
		}
    }
}