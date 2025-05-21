<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;

class RegisteredUserController extends Controller
{
    /**
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    /**
    * @OA\Post(
    *     path="/register",
    *     tags={"Auth"},
    *     summary="Registrar novo usuário",
    *     @OA\RequestBody(
    *         required=true,
    *         @OA\JsonContent(
    *             required={"name","email","password","password_confirmation"},
    *             @OA\Property(property="name", type="string"),
    *             @OA\Property(property="email", type="string", format="email"),
    *             @OA\Property(property="password", type="string", format="password"),
    *             @OA\Property(property="password_confirmation", type="string", format="password")
    *         )
    *     ),
    *     @OA\Response(response=201, description="Usuário registrado com sucesso"),
    *     @OA\Response(response=422, description="Erro de validação")
    * )
    */
    public function store(Request $request): Response
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->string('password')),
        ]);

        event(new Registered($user));

        Auth::login($user);

        return response()->noContent();
    }
}
