/*
	Trigger Handler Apex Class For the Travel Group Member Object
	Functionality:
	1) Set Medical Form Encrypted URL and set result as field

*/

public with sharing class Travel_Group_Member_Trigger_Handler extends Trigger_Handler {
	private final integer linkLength = 2000;
	public static FormAssembly_Encryption formAssem;

	public Travel_Group_Member_Trigger_Handler() {
		
	}


	/***************************************
    ********** Override Methods*************
    ***************************************/

	//Override Before Update Method
	public override void beforeUpdate(){
		setEncryptedFields();
	}


	/***************************************
    *********** Private Methods*************
    ***************************************/

	//Set the Medical Form URL Encrypted Fields on the travel Group Member
	private void setEncryptedFields(){
		
		//if form assembly class not been initialised yet
		if(formAssem == null){
			//Initialise Encryption Class
			formAssem = new FormAssembly_Encryption();

			//Set Secret key and form URL from metadata
			formAssem.setURLandKeyFromCustomMetadata('Traveller_Details');
		}
		
		//Loop round records and set the field
		for(Travel_Group_Member__c tgm : (list<Travel_Group_Member__c>) Trigger.new){
			string link = '';
			link = formAssem.BuildFormURL('tgmid',tgm.id);
			if(link.length() > linkLength){
				system.debug(LoggingLevel.WARN, 'Link length is greater than ' + linkLength + '. Length = ' + link.length());
				link = link.substring(0, linkLength);
			}
			tgm.Traveller_Details_Form_Link__c = link;
		}
	}
}