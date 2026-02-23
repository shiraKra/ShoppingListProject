import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { DataService } from '../data'; // וודאי שהייבוא נכון

@Component({
  selector: 'app-list-view',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './list-view.html',
  styleUrl: './list-view.css'
})
export class ListViewComponent implements OnInit {
  searchTerm: string = '';
  products: any[] = [];

  constructor(private dataService: DataService) {}

  ngOnInit() {
    // טעינת המוצרים מה-Service
    this.products = this.dataService.getProducts();
    console.log('Products loaded:', this.products); // בדיקה בקונסול
  }

  get filteredProducts() {
    return this.products.filter(p => 
      p.name.toLowerCase().includes(this.searchTerm.toLowerCase())
    );
  }

  deleteProduct(id: number) {
    this.dataService.deleteProduct(id);
    this.products = this.dataService.getProducts();
  }
}