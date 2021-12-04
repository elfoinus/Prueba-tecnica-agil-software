<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
Use App\Models\Libro;
Use Log;

class LibroController extends Controller
{
    public function getAll(){
        $data = Libro::get();
        return response()->json($data, 200);
    }

    public function create(Request $request){
        $libro = new Libro();
        $libro->Titulo = $request['Titulo'];
        $libro->Autor = $request['Autor'];
        $libro->Costo = $request['Costo'] && $request['Costo'] > 0 ? $request['Costo'] : 0 ;
        $libro->Fecha = $request['Fecha'] && $request['Fecha'] > 0 ? $request['Fecha'] : 2000 ;
        $libro->PrecioSugerido = $request['PrecioSugerido'] && $request['PrecioSugerido'] > 0 ? $request['PrecioSugerido'] : 0 ;

        $libro->IdEditorial = 1; // crea los todos los libros por defecto en la editorial "desconocida"

        $libro->save(['timestamps' => FALSE]);
    
        return response()->json([
            'message' => "Successfully created",
            'success' => true
        ], 200);
    }
  
    public function delete($IdLibro ){
    $res = Libro::find($IdLibro )->delete();
    return response()->json([
        'message' => "Successfully deleted",
        'success' => true
    ], 200);
    }

    public function get($IdLibro ){
        $data = Libro::find($IdLibro);
        return response()->json($data, 200);
    }
  
    public function update(Request $request,$IdLibro ){
        $libro = Libro::find($IdLibro);
        $libro->Titulo = $request['Titulo'];
        $libro->Autor = $request['Autor'];
        $libro->Costo = $request['Costo'];
        $libro->Fecha = ($request['Fecha'] > 0 && $request['Fecha'] < 10000) ? str_pad($request['Fecha'], 4, "0", STR_PAD_LEFT   )  : 0 ;
        $libro->PrecioSugerido = $request['PrecioSugerido'];

        $libro->save(['timestamps' => FALSE]);
        return response()->json([
            'message' => "Successfully updated",
            'success' => true
        ], 200);
    }  
}
