import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  // ה-RouterModule הכרחי כדי שהניתוב (Routing) יעבוד
  imports: [RouterModule], 
  // ה-router-outlet הוא המקום שבו מוצגים המסכים (רשימה, עריכה, פרטים)
  template: `
    <div style="min-height: 100vh; background-color: #f8f9fa; padding: 20px;">
      <router-outlet></router-outlet>
    </div>
  `
})
export class AppComponent {
  // השם הזה תואם למה שכתבנו ב-main.ts
}