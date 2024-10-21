# Account_Contact_Manager
This requirement implements a salesforce solution to manage and track the number of Contacts by Contact Type for each Account. 
Features:

a)Custom button (Contact type) on Account record to trigger a LWC 
b)LWC displays a table of unique Contact Types based on Type and State for the selected Account.
c)Multiple contact types can be selected.
d)Creates or updates a custom object for unique combinations of Account, Type, and State.
e)Enforces validation rules to ensure the number of Contacts per combination does not exceed 5.
f)User-friendly error messages for validation failures.
g)Uses a mix of declarative tools (Flow) and custom code (Apex and Lightning Web Components) for future flexibility.


             Working functionality scenario using a code-based approach
             

1. Created a Data model to link the account to a custom object (Contact type)
   <img width="953" alt="image" src="https://github.com/user-attachments/assets/25dbe95f-893b-4dfa-a1b8-77e0451b4d9c">
2. Created new quick action button (contact type) on Account object
   <img width="926" alt="image" src="https://github.com/user-attachments/assets/2e0a2987-4a8a-454f-afe6-f5b97a9d0966">
3. Created dummy data which consists of the unique combination of Type & State
   <img width="632" alt="image" src="https://github.com/user-attachments/assets/0d248f8b-25fa-49a3-bc51-ab685282c884">
4. Click on the button Contact Type, display the Type, State and # of contacts with the row selectable option
   <img width="590" alt="image" src="https://github.com/user-attachments/assets/5ab41722-5945-4b02-a540-c8684d35249d">
5. Click on the process selected, display success validation for further processing where it checks if a unique combination exists, updates the number of contacts else creates a record
  <img width="575" alt="image" src="https://github.com/user-attachments/assets/72b50d78-b440-4b51-a408-56a6add06e82">

6. In this case, the new record is created with copying on the fields provided in the previous step
   also created list view to view the records at one go
   <img width="953" alt="image" src="https://github.com/user-attachments/assets/7b7c9e28-f37c-4347-9eb1-815329b06e10">
7. Now i will process to update the existing record & other contact selection process, in this case, for existing record, number of contact field is updated to 3 & other 2 new records are created
   <img width="953" alt="image" src="https://github.com/user-attachments/assets/0b69e2d9-9985-4ee2-904a-45546b6c31e7">
8. If the number of contacts exceeds 5, then display user user-friendly error message
   ![image](https://github.com/user-attachments/assets/d80024b3-bb65-4f7f-bf42-3667aaca58ea)
   <img width="953" alt="image" src="https://github.com/user-attachments/assets/633a7936-2ded-43b8-88ff-ef61ef92896d">
10. If none of the rows is selected & clicked on the process selected, display the user-friendly error msg
   <img width="940" alt="image" src="https://github.com/user-attachments/assets/5daf1a35-7719-4df0-ba68-7e09ecddd167">



               Partially developed using a declarative tool (Flow) & highlighting the challenges below.
   
1.Fetcing the unique combination of Type & State for the contacts
<img width="956" alt="image" src="https://github.com/user-attachments/assets/3125ead9-6086-4e92-a213-1f41c41df2a2">
Issues:
I)Multiple loops, decision elements, assignments which slow down the performance in the long run if it has a large dataset of records
II)Debugging complexity -> With multiple loops & decision element flow becomes quite complex to debug,  If a combination isn’t added correctly or if the flow breaks due to an error, it 
may be challenging to track down where the problem occurred.
III)Error handling cannot be done efficiently on flow, because it has a basic element called FAULT path.
Iv)One of the biggest challenges encountered was the difference between text and record collections. When passing data between flows 
or subflows, I needed to pass collections of records (with fields like Type, State, and Number of Contacts), but I initially dealt with text collections that caused limitations in using 
declarative tools like the data table component. This required additional manipulation, which added complexity.
2.Created sub-flow for creating/updating the fields Type, State, Contact Count in Contact_Type__c custom object
<img width="377" alt="image" src="https://github.com/user-attachments/assets/f45042dc-a155-423f-bf95-05cdb3c837b7">
Issue: Unable to pass the text collection variable to subflow as highlighted above.
3.A data table is created to display data from the contact object, however here we need to pass the output from main flow to subflow, or can add screensflow inside the mainflow,..but the biggest challenge is again the text/record 
collection variable data table always accepts the record collection.
Biggest drawback: The data table will only display the first 2000 records in the input collection. A collection passed in with more than 2000 records could cause an Apex CPU time limit exceeded error.
<img width="725" alt="image" src="https://github.com/user-attachments/assets/cbd989ee-257e-4bb2-84bb-9b61759f400b">
once clubbed all the subflow, this is how it looks
<img width="374" alt="image" src="https://github.com/user-attachments/assets/296c36b9-7ffe-464c-b220-65b3673462e4">
created a button to invoke the flow
<img width="917" alt="image" src="https://github.com/user-attachments/assets/a475c2c2-9b95-40db-bc16-b1657e4e1f7c">
NOTE:To achieve the above requirement using a declarative tool is possible, but it leads to a lot of complexity 





     To achieve the above requirement using a declarative tool is possible , but leads to lot of complexity 


   




   

   


