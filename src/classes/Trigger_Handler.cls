/*
    Apex Virtual Class used for all Triggers
    No recursion handeling needed at this time.
    
    Use:
    - Create Handler (Apex Class) for Object and Extend this class
    - Override Trigger methods that are needed
    - Use Run() Method in the trigger. No other logic should be in the trigger!
*/

public virtual class Trigger_Handler {
  
    /***************************************
    ************* Constructor***************
    ***************************************/
    public Trigger_Handler() {
        this.setTriggerContext();
    }

    @TestVisible
    private TriggerContext context;

    //the current context of the trigger, overridable in tests
    @TestVisible
    private Boolean isTriggerExecuting;


    /***************************************
    ***** Redirecting To Correct Method*****
    ***************************************/

    public void run() {

        if(!validateRun()) return;

        // dispatch to the correct handler method
        if(this.context == TriggerContext.BEFORE_INSERT) {
            this.beforeInsert();
        } 
        else if(this.context == TriggerContext.BEFORE_UPDATE) {
            this.beforeUpdate();
        } 
        else if(this.context == TriggerContext.BEFORE_DELETE) {
            this.beforeDelete();
        } 
        else if(this.context == TriggerContext.AFTER_INSERT) {
            this.afterInsert();
        } 
        else if(this.context == TriggerContext.AFTER_UPDATE) {
            this.afterUpdate();
        } 
        else if(this.context == TriggerContext.AFTER_DELETE) {
            this.afterDelete();
        } 
        else if(this.context == TriggerContext.AFTER_UNDELETE) {
            this.afterUndelete();
        }
    }



    /***************************************
    ***** Private Instance Methods**********
    ***************************************/

    //Check Method is being called from Trigger
    private Boolean validateRun() {
        if(!this.isTriggerExecuting || this.context == null) {
            throw new TriggerHandlerException('Trigger handler called outside of Trigger execution');
            return false;
        }
        return true;
    }

    //Get the Name of the Handler Calling the Trigger
    private String getHandlerName() {
        return String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    }

    @TestVisible
    private void setTriggerContext() {
        this.setTriggerContext(null, false);
    }

    @TestVisible
    private void setTriggerContext(String ctx, Boolean testMode) {
        if(!Trigger.isExecuting && !testMode) {
            this.isTriggerExecuting = false;
            return;
        } 
        else {
            this.isTriggerExecuting = true;
        }

        if((Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) || (ctx != null && ctx == 'before insert')) {
            this.context = TriggerContext.BEFORE_INSERT;
        } 
        else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate) || (ctx != null && ctx == 'before update')){
            this.context = TriggerContext.BEFORE_UPDATE;
        } 
        else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete) || (ctx != null && ctx == 'before delete')) {
            this.context = TriggerContext.BEFORE_DELETE;
        } 
        else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) || (ctx != null && ctx == 'after insert')) {
            this.context = TriggerContext.AFTER_INSERT;
        } 
        else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate) || (ctx != null && ctx == 'after update')) {
            this.context = TriggerContext.AFTER_UPDATE;
        } 
        else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete) || (ctx != null && ctx == 'after delete')) {
            this.context = TriggerContext.AFTER_DELETE;
        } 
        else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete) || (ctx != null && ctx == 'after undelete')) {
            this.context = TriggerContext.AFTER_UNDELETE;
        }
    }


    /***************************************
    ********** Virtual methods *************
    ***************************************/

    // context-specific methods for override
    @TestVisible
    protected virtual void beforeInsert(){}
    @TestVisible
    protected virtual void beforeUpdate(){}
    @TestVisible
    protected virtual void beforeDelete(){}
    @TestVisible
    protected virtual void afterInsert(){}
    @TestVisible
    protected virtual void afterUpdate(){}
    @TestVisible
    protected virtual void afterDelete(){}
    @TestVisible
    protected virtual void afterUndelete(){}


    /***************************************
    ********** Exception Class**************
    ***************************************/
    public class TriggerHandlerException extends Exception {}

    // possible trigger contexts
    @TestVisible
    private enum TriggerContext {
        BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,
        AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE,
        AFTER_UNDELETE
    }

}