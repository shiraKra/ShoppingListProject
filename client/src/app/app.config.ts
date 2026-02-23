import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';
import { routes } from './app.routes'; // מוודא שהוא מושך את ה-routes מהקובץ שתיקנו עכשיו

export const appConfig: ApplicationConfig = {
  providers: [provideRouter(routes)]
};