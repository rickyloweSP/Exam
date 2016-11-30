/*
	Test Class coveres 'Trigger_handler' class 

*/

@isTest
private class Trigger_Handler_Test {
	private static Trigger_Handler handler;
	
	@isTest static void TestBeforeInsert() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('before insert', true);
		trigHand.run();
	}

	@isTest static void TestAfterInsert() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('after insert', true);
		trigHand.run();
	}

	@isTest static void TestBeforeUpdate() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('before update', true);
		trigHand.run();
	}

	@isTest static void TestAfterUpdate() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('after update', true);
		trigHand.run();
	}

	@isTest static void TestBeforeDelete() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('before delete', true);
		trigHand.run();
	}

	@isTest static void TestAfterDelete() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('after delete', true);
		trigHand.run();
	}

	@isTest static void TestAfterUndelete() {
		Trigger_Handler trigHand = new Trigger_Handler();
		trigHand.setTriggerContext('after undelete', true);
		trigHand.run();
	}
}