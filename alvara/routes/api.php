<?php

use App\Http\Controllers\ApplicationController;
use App\Http\Controllers\AttachmentController;
use App\Http\Controllers\CompanyController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\User;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use function Pest\Laravel\post;

/*Route::get('/user', function (Request $request) {*/
/*    return $request->user();*/
/*})->middleware('auth:sanctum');*/
/**/
/**/
/**/
/*Route::post('/login', function (Request $request) {*/
/*    $user = User::where('email', $request->email)->first();*/
/**/
/*    if (! $user || ! Hash::check($request->password, $user->password)) {*/
/*        return response()->json(['message' => 'Credenciais inválidas'], 401);*/
/*    }*/
/**/
/*    $token = $user->createToken('api-token')->plainTextToken;*/
/**/
/*    return response()->json(['token' => $token]);*/
/*});*/
/**/
/*Route::middleware('auth:sanctum')->get('/user', function (Request $request) {*/
/*    return $request->user();*/
/*});*/
/**/
/**/
/*Route::post('/logout', function (Request $request) {*/
/*    $request->user()->currentAccessToken()->delete();*/
/**/
/*    return response()->json(['message' => 'Logout feito com sucesso']);*/
/*})->middleware('auth:sanctum');*/
/**/
/**/
/*Route::post('/register', function (Request $request) {*/
/*    $request->validate([*/
/*        'name' => 'required|string|max:255',*/
/*        'email' => 'required|string|email|max:255|unique:users',*/
/*        'password' => 'required|string|min:8',*/
/*    ]);*/
/**/
/*    $user = User::create([*/
/*        'name' => $request->name,*/
/*        'email' => $request->email,*/
/*        'password' => Hash::make($request->password),*/
/*    ]);*/
/**/
/*    $token = $user->createToken('api-token')->plainTextToken;*/
/**/
/*    return response()->json(['token' => $token], 201);*/
/*});*/


/*Route::post("/attachments/upload", [AttachmentController::class, "upload"]);*/
/*Route::get("/attachments", [AttachmentController::class, "index"]);*/

/*Route::post("/applications", [ApplicationController::class, "store"]);*/

Route::apiResource(
    "/applications",
    ApplicationController::class
)->only(["index", "store", "show", "update", "destroy"]);

Route::prefix("/applications/{application}")->group(function () {
    Route::post("accept", [ApplicationController::class, "accept"]);
    Route::post("reject", [ApplicationController::class, "reject"]);
    Route::post("send", [ApplicationController::class, "send"]);
});


Route::apiResource(
    "companies",
    CompanyController::class
)->only(["index", "store", "show", "update", "destroy"]);
