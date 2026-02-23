import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterModule } from '@angular/router';
// שורת המחץ: וודאי שהייבוא הזה קיים ומדויק!
import { DataService } from '../data'; 

@Component({
  selector: 'app-item-details',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './item-details.html',
  styleUrl: './item-details.css'
})
export class ItemDetailsComponent implements OnInit {
  product: any;

  // הזרקת השירות - עכשיו אנגולר תכיר אותו בזכות ה-import למעלה
  constructor(
    private route: ActivatedRoute,
    private dataService: DataService 
  ) {}

  ngOnInit() {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    // שליפת הנתונים מהשירות המרכזי
    this.product = this.dataService.getProductById(id);
  }
}