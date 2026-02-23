import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormGroup, FormControl, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { DataService } from '../data'; // וודאי שהנתיב נכון

@Component({
  selector: 'app-edit-item',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './edit-item.html',
  styleUrl: './edit-item.css'
})
export class EditItemComponent implements OnInit {
  // 1. הגדרת הטופס עם ולידציה כפי שנדרש
  productForm = new FormGroup({
    name: new FormControl('', [Validators.required, Validators.minLength(2)]),
    category: new FormControl('', [Validators.required]),
    price: new FormControl(0, [Validators.required, Validators.min(0.1)]),
    status: new FormControl('זמין') // הוספת סטטוס שיהיה "ידידותי"
  });

  isEditMode: boolean = false;
  productId: number | null = null;
  categories = ['חלבי', 'מאפה', 'ירקות/פירות', 'ניקיון', 'בשר/דגים'];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private dataService: DataService
  ) {}

  ngOnInit() {
    // 2. שליפת ה-ID וטעינת נתונים לעריכה
    const idParam = this.route.snapshot.paramMap.get('id');
    if (idParam) {
      this.isEditMode = true;
      this.productId = Number(idParam);
      
      const product = this.dataService.getProductById(this.productId);
      if (product) {
        // מילוי הטופס בנתונים הקיימים
        this.productForm.patchValue(product);
      }
    }
  }

  // 3. פונקציית השמירה שמבדילה בין יצירה לעדכון
  onSubmit() {
    if (this.productForm.valid) {
      const formValues = this.productForm.value;

      if (this.isEditMode && this.productId !== null) {
        // עדכון מוצר קיים - חייבים לצרף את ה-ID המקורי לשירות
        this.dataService.updateProduct({ 
          ...formValues, 
          id: this.productId 
        });
      } else {
        // יצירת מוצר חדש
        this.dataService.addProduct(formValues);
      }
      
      // חזרה אוטומטית לרשימה כדי לראות את העדכון
      this.router.navigate(['/']);
    }
  }
}