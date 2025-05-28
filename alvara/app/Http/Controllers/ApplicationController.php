<?php

namespace App\Http\Controllers;

use App\Enums\ApplicationLicenseType;
use App\Models\Application;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Symfony\Component\HttpFoundation\JsonResponse;

class ApplicationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Application::all();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            "title" => "required|string|max:225",
            "type" => ["required", Rule::enum(ApplicationLicenseType::class)],
            "company_id" => "required|exists:companies,id",
        ]);

        $application = Application::create($validated);

        return response()->json($application, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Application $application)
    {
        return $application;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Application $application)
    {
        $validated = $request->validate([
            "status"=> "required|string|max:3",
            "title"=> "required|string|max:225",
        ]);

        $application->update($validated);

        return $application;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Application $application)
    {
        $application->delete();
        return response()->json([
            "message" => "Deletado com successo"
        ]);
    }

    public function accept(Application $application): JsonResponse {
        $application->getStatusController()->accept();
        return response()->json([
            "message" => "A Solicitação foi Aceita!"
        ]);
    }

    public function reject(Application $application): JsonResponse {
        $application->getStatusController()->reject();
        return response()->json([
            "message" => "A Solicitação foi Rejeitada!"
        ]);
    }

    public function send(Application $application): JsonResponse {
        $application->getStatusController()->send();
        return response()->json([
            "message" => "A Solicitação foi Enviada!"
        ]);
    }
}
