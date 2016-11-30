/*
	Apex Class used to encrypt the URL parameters to be sent to FormAssembly
*/


//https://www.tfaforms.com/forms/view/414154?tgmid=a01N000000BFuRl

public without sharing class FormAssembly_Encryption {
	private string secretKey;
	private string FormURL;


	//Constructor 
	public FormAssembly_Encryption() {

	}

	//Public set Secret key method
	public void setSecretKey(string keyIn){
		secretKey = keyIn;
	}

	//Set URL and Key from Custom metadata
	public void setURLandKeyFromCustomMetadata(string MetadataRecordName){
		FormAssembly_Form_Encryption__mdt custMet = [select id, URL__c, Secret_Key__c from FormAssembly_Form_Encryption__mdt where DeveloperName = :MetadataRecordName];
		if(custMet != null){
			secretKey = custMet.Secret_Key__c;
			FormURL = custMet.URL__c;
		}
	}

	//Method Encrypts Input Text with Secret Key
	public string EncryptString(string strIn){
		String encryptedString = '';
		if(strIn != null){
			try{
				Blob mac = Crypto.generateMac('HMacSHA256', Blob.valueOf(strIn), Blob.valueOf(secretKey) );
				encryptedString = EncodingUtil.urlEncode(EncodingUtil.base64Encode(mac), 'UTF-8');	
			}
			catch (exception e){
				system.debug(LoggingLevel.ERROR, 'There was an error during encryption');
			}
		}
		else{
			system.debug(LoggingLevel.ERROR, 'User privided null value to be encrypted');
		}
		return encryptedString;
	}

	/*
	//Method builds Form by encrypting parameter and adding encrypted and unencrpted version in the URL along with the Form URL
		@parameter = name of the FormAssembly Parameter
		@value = value of the FormAssembly parameter
	*/
	public string BuildFormURL(string parameter, string value, string FormURL){
		String sig = EncryptString(parameter + value);
		String url = this.formURL + '?' + parameter + '=' + value + '&signature=' + sig;
		return url;
	}

	/*
	Build Form URL - using Class URL
		@parameter = name of the FormAssembly Parameter
		@value = value of the FormAssembly parameter
	*/

	public string BuildFormURL(string parameter, string value){
		if(FormURL != null){
			String url = BuildFormURL(parameter, value, FormURL);
			return url;
		}
		else{
			return '';
		}
	}
}