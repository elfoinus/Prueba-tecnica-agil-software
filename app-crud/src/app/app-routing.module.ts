import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IndexComponent } from './book/index/index.component';

const routes: Routes = [
  {path:'' , component: IndexComponent } // hace que cargue inicialmente el compónente de book index
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
