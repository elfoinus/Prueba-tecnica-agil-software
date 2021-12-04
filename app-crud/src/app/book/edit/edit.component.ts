import { Component, OnInit } from '@angular/core';

import { BookService } from '../book.service';
import { ActivatedRoute, Router } from '@angular/router';
import { FormGroup, FormControl, Validators} from '@angular/forms';
import { Book } from '../book';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.css']
})
export class EditComponent implements OnInit {

  IdLibro: number;
  book: Book;
  form: FormGroup;

  constructor(
    public bookService: BookService,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.book = {
      IdLibro         : 0,
      Titulo          : "",
      IdEditorial     : 0,
      Fecha           : 0,
      Costo           : 0,
      PrecioSugerido  : 0,
      Autor           : ""
    }
    this.IdLibro = this.route.snapshot.params['IdLibro'];
    this.bookService.find(this.IdLibro).subscribe((data: Book)=>{
      this.book = data;  
    });
    
  
    this.form = new FormGroup({
      Titulo: new FormControl('', [ Validators.required ]),
      Autor: new FormControl('', [  ]),
      Fecha: new FormControl('', [ Validators.maxLength(4),  Validators.pattern("^[0-9]*$"),Validators.min(2000) ]),
      Costo: new FormControl('', [ Validators.required, Validators.pattern("^[0-9]*$"),, Validators.min(0) ]),
      PrecioSugerido: new FormControl('', [ Validators.required, Validators.pattern("^[0-9]*$"),, Validators.min(0) ])
    });
  }

  get f(){
    return this.form.controls;
  }

  submit(){
    console.log(this.form.value);
    this.bookService.update(this.IdLibro, this.form.value).subscribe(res => {
         console.log('Libro actualizado correctamente!');
         this.router.navigateByUrl('book/index');
    })
  }

}
