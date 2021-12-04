import { Component, OnInit } from '@angular/core';

import { BookService } from '../book.service';
import { Book } from '../book';

@Component({
  selector: 'app-index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css']
})
export class IndexComponent implements OnInit {

  books: Book[] = [];
  
  //constructor() { }
  constructor(public bookService: BookService) { }
  
  ngOnInit(): void {
    this.bookService.getAll().subscribe((data: Book[])=>{
      this.books = data;
      console.log(this.books);
    })
  }

  deleteBook(id){
    this.bookService.delete(id).subscribe(res => {
         this.books = this.books.filter(item => item.IdLibro !== id);
         console.log('Libro borrado correctamente!');
    })
  }

}
