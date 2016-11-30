/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_Travel_Group_MemberTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_Travel_Group_MemberTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new Travel_Group_Member__c());
    }
}