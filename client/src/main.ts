import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app'; // ייבוא הקומפוננטה ששלחת הרגע

// הפקודה שמחברת את הכל ומריצה את האתר בדפדפן
bootstrapApplication(AppComponent, appConfig)
  .catch((err) => {
    // אם יש שגיאה בהפעלה, היא תופיע כאן בקונסול (F12)
    console.error('שגיאה בהפעלת האפליקציה:', err); 
  });
