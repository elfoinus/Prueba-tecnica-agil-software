import { Component, OnInit } from '@angular/core';
import { BookService } from '../book.service';
import { Router } from '@angular/router';
import { FormGroup, FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class CreateComponent implements OnInit {

  form: FormGroup;
  constructor(
    public bookService: BookService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.form = new FormGroup({
      //Titulo:  new FormControl('', [ Validators.required, Validators.pattern('^[a-zA-ZÁáÀàÉéÈèÍíÌìÓóÒòÚúÙùÑñüÜ \-\']+') ]),
      //email: new FormControl('', [ Validators.required, Validators.email ]),
      Titulo: new FormControl('', [ Validators.required ]),
      Autor: new FormControl('', [ Validators.required,  ]),
      Fecha: new FormControl('', [ Validators.maxLength(4),  Validators.pattern("^[0-9]*$") ,Validators.min(2000)]),
      Costo: new FormControl('', [ Validators.required, Validators.pattern("^[0-9]*$"), Validators.min(0) ]),
      PrecioSugerido: new FormControl('', [ Validators.required, Validators.pattern("^[0-9]*$"), Validators.min(0) ])
    });
  }

  get f(){
    return this.form.controls;
  }

  submit(){
    console.log(this.form.value);
    this.bookService.create(this.form.value).subscribe(res => {
         console.log('Libro creado correctamente');
         this.router.navigateByUrl('book/index');
    })
  }
}
