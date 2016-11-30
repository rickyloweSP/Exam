/*
	Apex Trigger For the Travel Group Member.
	See Apex Class: 'Travel_Group_Member_Trigger_Handler' for logic.
	***Do not modify***
*/

trigger Travel_Group_Member_Trigger on Travel_group_member__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) 
{
	Travel_Group_Member_Trigger_Handler tgm = new Travel_Group_Member_Trigger_Handler();
	tgm.run();
}