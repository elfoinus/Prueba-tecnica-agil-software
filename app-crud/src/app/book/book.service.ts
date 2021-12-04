import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import {  Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

import { Book } from './book';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  private apiURL = "http://localhost:8000/api/libro/";

  httpOptions = {
     headers: new HttpHeaders({
       'Content-Type': 'application/json'
     })
  }

  constructor(private httpClient: HttpClient) { }

  getAll(): Observable<Book[]> {
   return this.httpClient.get<Book[]>(this.apiURL)
   .pipe(
     catchError(this.errorHandler)
   )
 }

 create(book): Observable<Book> {
   return this.httpClient.post<Book>(this.apiURL, JSON.stringify(book), this.httpOptions)
   .pipe(
     catchError(this.errorHandler)
   )
 }

 find(id): Observable<Book> {
   return this.httpClient.get<Book>(this.apiURL + id)
   .pipe(
     catchError(this.errorHandler)
   )
 }

 update(id, book): Observable<Book> {
   return this.httpClient.put<Book>(this.apiURL + id, JSON.stringify(book), this.httpOptions)
   .pipe(
     catchError(this.errorHandler)
   )
 }

 delete(id){
   return this.httpClient.delete<Book>(this.apiURL + id, this.httpOptions)
   .pipe(
     catchError(this.errorHandler)
   )
 }

 errorHandler(error) {
   let errorMessage = '';
   if(error.error instanceof ErrorEvent) {
     errorMessage = error.error.message;
   } else {
     errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
   }
   return throwError(errorMessage);
 }
}
