import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root' // הופך את השירות לזמין בכל האפליקציה
})
export class DataService {
  // המערך המרכזי שכל המסכים ישתמשו בו
  private products = [
    { id: 1, name: 'חלב', category: 'חלבי', price: 6.5, status: 'זמין' },
    { id: 2, name: 'לחם פנים', category: 'מאפה', price: 12, status: 'חסר' }
  ];

  // שליפת כל המוצרים עבור מסך 1
  getProducts() {
    return this.products;
  }

  // שליפת מוצר בודד לפי ה-ID שלו (למסכי עריכה ופרטים)
  getProductById(id: number) {
    return this.products.find(p => p.id === id);
  }

  // מחיקת מוצר מהרשימה המרכזית
  deleteProduct(id: number) {
    this.products = this.products.filter(p => p.id !== id);
  }

  // הוספת מוצר חדש עם יצירת ID אוטומטי
  addProduct(product: any) {
    const newId = this.products.length > 0 ? Math.max(...this.products.map(p => p.id)) + 1 : 1;
    this.products.push({ ...product, id: newId });
  }

  // עדכון מוצר קיים לפי ה-ID שלו
  updateProduct(updatedProduct: any) {
  const index = this.products.findIndex(p => p.id === updatedProduct.id);
  if (index !== -1) {
    this.products[index] = { ...this.products[index], ...updatedProduct };
  }
}
}