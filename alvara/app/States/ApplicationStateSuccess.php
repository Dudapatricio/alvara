<?php

namespace App\States;

use App\Models\Application;
use Illuminate\Http\Exceptions\HttpResponseException;

class ApplicationStateSuccess implements IApplicationState {
    protected Application $application;

    public function __construct(Application $application) {
        $this->application = $application;
    }

    public function send(): void
    {
        throw new HttpResponseException(response()->json([
            "message" => "A Solicitação foi Aceita"
        ], 400));
    }

    public function accept(): void
    {
        throw new HttpResponseException(response()->json([
            "message" => "A Solicitação já foi Aceita"
        ], 400));
    }

    public function reject(): void
    {
        throw new HttpResponseException(response()->json([
            "message" => "A Solicitação foi Aceita"
        ], 400));
    }

}

