import { LightningElement, wire } from 'lwc';
import GetAccounts from '@salesforce/apex/getAccountlist.GetAccounts';
  
export default class AccountListLWC extends LightningElement {
    @wire(GetAccounts) accounts;
}