//created as part of assignment
public with sharing class ContactTypeController {
    
    @AuraEnabled(cacheable=true)
    public static List<ContactTypeWrapper> getContactTypes(Id accountId) {
        List<ContactTypeWrapper> contactTypeList = new List<ContactTypeWrapper>();
        
        // Query to get unique combinations of Type and State, and count contacts
        List<AggregateResult> results = [
            SELECT Type__c, State__c, COUNT(Id) numberOfContacts
            FROM Contact
            WHERE AccountId = :accountId
            GROUP BY Type__c, State__c
        ];

        // Wrap the contact data with the number of contacts from Account
        for (AggregateResult result : results) {
            contactTypeList.add(new ContactTypeWrapper(
                (String)result.get('Type__c'),
                (String)result.get('State__c'),
                (Integer)result.get('numberOfContacts')
            ));
        }       
        return contactTypeList;
    }

    @AuraEnabled
    public static void processContactTypes(String selectedRows, Id accountId) {
        // Deserialize the selected rows from JSON
        List<ContactTypeWrapper> selectedRowsList = (List<ContactTypeWrapper>) JSON.deserialize(selectedRows, List<ContactTypeWrapper>.class);
        List<Contact_Type__c> recordsToInsertOrUpdate = new List<Contact_Type__c>();

        // Query existing Contact_Type__c records to check for duplicates
        Map<String, Contact_Type__c> existingRecordsMap = new Map<String, Contact_Type__c>();
        List<Contact_Type__c> existingRecords = [
            SELECT Id, Type__c, State__c, Number_of_Contacts__c
            FROM Contact_Type__c
            WHERE Account__c = :accountId
        ];

        // Create a map with key as a combination of Type__c and State__c for quick lookup
        for (Contact_Type__c record : existingRecords) {
            String key = record.Type__c + record.State__c;
            existingRecordsMap.put(key, record);
        }

        // Process each selected row from the LWC
        for (ContactTypeWrapper row : selectedRowsList) {
            String key = row.type + row.state;
            if (existingRecordsMap.containsKey(key)) {
                // Record exists, so update the Number_of_Contacts__c field
                Contact_Type__c existingRecord = existingRecordsMap.get(key);
                existingRecord.Number_of_Contacts__c += 1;
                
                recordsToInsertOrUpdate.add(existingRecord);
            } else {
                // Record doesn't exist, so create a new Contact_Type__c record
                Contact_Type__c newRecord = new Contact_Type__c();
                newRecord.Account__c = accountId;
                newRecord.Type__c = row.type;
                newRecord.State__c = row.state;
                newRecord.Number_of_Contacts__c = row.numberOfContacts;

                recordsToInsertOrUpdate.add(newRecord);
            }
        }

        // Insert or update records in bulk
        if (!recordsToInsertOrUpdate.isEmpty()) {
            upsert recordsToInsertOrUpdate;
        }
    }

    // Wrapper class to hold the response data
    public class ContactTypeWrapper {
        @AuraEnabled public String type { get; set; }
        @AuraEnabled public String state { get; set; }
        @AuraEnabled public Integer numberOfContacts { get; set; }

        public ContactTypeWrapper(String type, String state, Integer numberOfContacts) {
            this.type = type;
            this.state = state;
            this.numberOfContacts = numberOfContacts;
        }
    }
}
