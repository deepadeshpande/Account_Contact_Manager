import { LightningElement, api, track } from 'lwc';

export default class UniqueTypeStateCollection extends LightningElement {
    // Public property to accept the data from the flow
    @api typeStateData = [];

    // Define the columns for the datatable
    columns = [
        { label: 'Type', fieldName: 'type' },
        { label: 'State', fieldName: 'state' },
        { label: 'Number of Contacts', fieldName: 'contactCount', type: 'number' }
    ];

    // For displaying data in the table
    get hasData() {
        return this.typeStateData && this.typeStateData.length > 0;
    }
}
