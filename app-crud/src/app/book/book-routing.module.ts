import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IndexComponent } from './index/index.component';
import { CreateComponent } from './create/create.component';
import { EditComponent } from './edit/edit.component';

const routes: Routes = [
  { path: 'book', redirectTo: 'book/index', pathMatch: 'full'},
  { path: 'book/index', component: IndexComponent },
  { path: 'book/create', component: CreateComponent },
  { path: 'book/edit/:IdLibro', component: EditComponent } 
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BookRoutingModule { }
