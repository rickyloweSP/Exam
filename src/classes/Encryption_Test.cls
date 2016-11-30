@isTest (seealldata = false)
private class Encryption_Test {
	
	//Test setting the URL and Encryption 
	@isTest static void EncryptFromMetadata() {
		FormAssembly_Encryption form = new FormAssembly_Encryption();
		form.setURLandKeyFromCustomMetadata('Traveller_Details');
		string urlOut = form.BuildFormURL('testParam','testValue');
		system.debug('Form URL = ' + urlOut);
		system.assert(urlOut != '');
	}
	
	//Test setting the secret key and form URL manually
	@isTest static void EncryptFromManualKey() {
		FormAssembly_Encryption form = new FormAssembly_Encryption();
		form.setSecretKey('secretkey');
		string urlOut = form.BuildFormURL('testParam','testValue','formURL');
		system.assert(urlOut != '');
	}

	//Test not setting an Encryption Key
	@isTest static void EncryptNoKey() {
		FormAssembly_Encryption form = new FormAssembly_Encryption();
		string urlOut = form.EncryptString('StringIn');
		system.assert(urlOut == '');
	}

	//Test not setting a form url
	@isTest static void NoFormURL() {
		FormAssembly_Encryption form = new FormAssembly_Encryption();
		string urlOut = form.BuildFormURL('testParam','testValue');
		system.assert(urlOut == '');
	}

	//Test null string in
	@isTest static void NullStringIn() {
		FormAssembly_Encryption form = new FormAssembly_Encryption();
		string strOut = form.EncryptString(null);
		system.assert(strOut == '');
	}

	//Test Travel Group Member Trigger
	@isTest static void TestInsertTGM() {
		createRecords();
		update TGM;
		system.assert(TGM.Traveller_Details_Form_Link__c != '');
	}

	private static Travel_Group_Member__c TGM;

	private static void createRecords(){
		//recordType AccRT = [Select id from recordtype where developerName = 'institution' AND sobjectType = 'Account'];
		
		//Setup map
		map<string, id> RTMap = new map<string, id>();
		for(recordType RT : [Select id, developerName from recordtype where sobjectType = 'Account' OR sobjectType = 'Opportunity' OR sobjectType = 'Travel_group__c' OR sobjectType = 'Travel_Group_member__c' OR sobjectType = 'contact']){
			RTMap.put(RT.developerName, RT.id);
		}


		Account Acc = new Account(name = 'test', recordtypeid = RTMap.get('Institution'));
		insert Acc;

		Opportunity opp = new Opportunity(name = 'testOpp', recordtypeid = RTMap.get('University_Opportunity'), closeDate = date.today(), AccountID = Acc.id, StageName = '1 - New Opportunity');
		insert opp;

		Travel_Group__c TG = new Travel_Group__c(name = 'test', recordtypeid = RTMap.get('Faculty_Placement'), opportunity__c = opp.id);
		insert TG;

		contact cont = new Contact(recordtypeid = RTMap.get('Traveller'), firstName = 'test', lastName = 'test', email = 'email@test.com');
		insert cont;

		TGM = new Travel_Group_Member__c(recordtypeid = RTMap.get('Paying_and_Travelling'), participant__c = cont.id, travel_group__c = TG.id);
		insert TGM;
	}



	
}