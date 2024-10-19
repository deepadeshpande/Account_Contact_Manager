/* created as part of assignment */

public with sharing class ErrorLogger {

    /**
     * Logs an error into the custom ErrorLog__c object.
     * 
     * @param errorMessage    The error message to log
     * @param errorCode       A custom error code, if applicable
     * @param errorDescription A detailed description of the error, stack trace, etc.
     */
    public static void logError(String errorMessage, String errorCode, String errorDescription) {
        try {
            ErrorLog__c errorLog = new ErrorLog__c();
            errorLog.ErrorMessage__c = errorMessage;
            errorLog.ErrorCode__c = errorCode;
            errorLog.ErrorDescription__c = errorDescription;
            
            // Insert the error log record into the database
            insert errorLog;
        } catch (Exception e) {
            // If there's an issue logging the error, log it to debug instead
            System.debug('Error logging failed: ' + e.getMessage());
        }
    }

   
}
