/*
 * Scheduled apex that runs every day at 1am to recalculate the next payment day for the 
 * Travel groups where the next payment day is in the past
 *
*/
global class Recalculate_Next_Payment_Date_Scheduled implements Schedulable {
	global void execute(SchedulableContext SC) {
        Recalculate_Next_Payment_Date_Batch batch = new Recalculate_Next_Payment_Date_Batch();
		database.executeBatch(batch,20);
    }
}