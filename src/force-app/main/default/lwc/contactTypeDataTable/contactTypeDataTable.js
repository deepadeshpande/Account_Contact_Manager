/* created as part of assignment */

import { LightningElement, track, wire, api } from 'lwc';
import getContactTypes from '@salesforce/apex/ContactTypeController.getContactTypes';
import processContactTypes from '@salesforce/apex/ContactTypeController.processContactTypes';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactTypeDataTable extends LightningElement {
    @track contactTypeData = []; // Holds the datatable data
    @track selectedRows = []; // To store selected rows
    @track error;
    @api recordId; // pass the recordId when invoked via custom button

    // Define the columns for the datatable
    columns = [
        { label: 'Type', fieldName: 'type', type: 'text' },
        { label: 'State', fieldName: 'state', type: 'text' },
        { label: 'Number of Contacts', fieldName: 'numberOfContacts', type: 'number' }
    ];

    // Fetch contact types for the current account
    @wire(getContactTypes, { accountId: '$recordId' })
    wiredContactTypes({ error, data }) {
        if (data) {
            this.contactTypeData = data;
            this.error = undefined;
        } else if (error) {
            console.error('Error fetching contact types:', error);
            this.error = error;
            this.showToast('Error', 'Error fetching contact types', 'error');
        }
    }
    // Handler for row selection
    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
        console.log('Selected Rows:', this.selectedRows);
    }

    // Handler to process selected rows
    handleProcessSelected() {
        if (this.selectedRows.length === 0) {
            this.showToast('Error', 'Please select at least one row to proceed.', 'error');
            return;
        }
        // Call the Apex method to process the selected rows
        processContactTypes({ selectedRows: JSON.stringify(this.selectedRows), accountId: this.recordId })
            .then(() => {
                this.showToast('Success', 'Selected rows processed successfully.', 'success');
            })
            .catch(error => {
                this.showToast('Error', 'Contact count cannot exceed 5', 'error');
            });
    }
    // Utility method to show toast notifications
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}
