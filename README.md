# Account_Contact_Manager
This requirement implements a salesforce solution to manage and track the number of Contacts by Contact Type for each Account. 
Features:
Custom button (Contact type) on Account record to trigger a LWC 
LWC displays a table of unique Contact Types based on Type and State for the selected Account.
Multiple contact types can be selected.
Creates or updates a custom object for unique combinations of Account, Type, and State.
Enforces validation rules to ensure the number of Contacts per combination does not exceed 5.
User-friendly error messages for validation failures.
Uses a mix of declarative tools (Flow) and custom code (Apex and Lightning Web Components) for future flexibility.


             Working functionality scenario using a code-based approach

1. Created Data model to link the account to custom object (Contact type)
   <img width="953" alt="image" src="https://github.com/user-attachments/assets/25dbe95f-893b-4dfa-a1b8-77e0451b4d9c">
2. Created new quick action button (contact type) on Account object
   <img width="926" alt="image" src="https://github.com/user-attachments/assets/2e0a2987-4a8a-454f-afe6-f5b97a9d0966">
3. Created dummy data which consist of unique combination of Type & State
   <img width="637" alt="image" src="https://github.com/user-attachments/assets/c856fc21-c7fc-4f74-826e-9ef27e396832">
4. Click on button Contact Type, display the Type, State and # of contacts with row selectable option
   <img width="590" alt="image" src="https://github.com/user-attachments/assets/5ab41722-5945-4b02-a540-c8684d35249d">
5. Click on process selected , display success validation for further processing where it check if unique combination exists? update the number of contact: createnew record
   ![image](https://github.com/user-attachments/assets/e57d16e4-0c58-4d4b-81d5-fa52dee86081)
5. In this case, the new record & existing record is updated, for first time record is created & for existing contact count updated in new custom object Contact_Type__c
   <img width="959" alt="image" src="https://github.com/user-attachments/assets/dd63390b-727e-48c4-acc1-d0764fec2dc8">
6. If number of contact exceeds 5, then display user friendly error message
   ![image](https://github.com/user-attachments/assets/d80024b3-bb65-4f7f-bf42-3667aaca58ea)


               Partially developed using a declarative tool (Flow) & highlighting the challenges below.
 1. Fetcing the unique combination of Type & State for the contacts
      <img width="956" alt="image" src="https://github.com/user-attachments/assets/3125ead9-6086-4e92-a213-1f41c41df2a2">
      Issue:
      I)Multiple loops, decision elements, assignment which slow down the performance in the long run if it has a large dataset of records
      II) Debugging complexity -> With multiple loops & decision element flow becomes quite complex to debug,  If a combination isn’t added correctly or if the flow breaks due to an error, it 
      may be challenging to track down where the problem occurred.
      III) Error handling cannot be done efficiently on flow, because it has a basic element called FAULT path.
      Iv) One of the biggest challenges we encountered was the difference between text and record collections. When passing data between flows 
      or subflows, I needed to pass collections of records (with fields like Type, State, and Number of Contacts), but I initially dealt with text collections that caused limitations in using 
      declarative tools like the data table component. This required additional manipulation, which added complexity.
 2. Created sub-flow for creating/updating the fields Type, State, Contact Count in Contact_Type__c custom object
      <img width="351" alt="image" src="https://github.com/user-attachments/assets/d5dc7f57-ebb0-411b-aae8-681c076424a8">
      Issue: Unable to pass the text collection variable to subflow as highlighted above.
3. This is just created to show datatable is not natively available, workaround would be to use multiselect picklist or checbox group , but again it will not look like
     datatable, hence UI is not feasible...but the biggest challenge is again the text/record collection variable
     <img width="251" alt="image" src="https://github.com/user-attachments/assets/82e6cbd7-d245-46b7-8bc5-c8132e6471e7">

     To achieve the above requirement using a declarative tool would not be feasible because of the complexity involved. 


   




   

   


