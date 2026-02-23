import { Routes } from '@angular/router';
import { ListViewComponent } from './list-view/list-view';
import { EditItemComponent } from './edit-item/edit-item';
import { ItemDetailsComponent } from './item-details/item-details';

export const routes: Routes = [
  { path: '', component: ListViewComponent },           // מסך 1: רשימה
  { path: 'edit/:id', component: EditItemComponent },    // מסך 2: עריכה
  { path: 'details/:id', component: ItemDetailsComponent }, // מסך 3: פרטים
  { path: 'create', component: EditItemComponent }       // מסך 2: יצירה
];