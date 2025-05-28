<?php

namespace App\States;

use App\Enums\ApplicationStatus;
use App\Models\Application;
use Illuminate\Http\Exceptions\HttpResponseException;

class ApplicationStateOpen implements IApplicationState {

    protected Application $application;

    public function __construct(Application $application) {
        $this->application = $application;
    }
    public function send(): void
    {
        $this->application->status = ApplicationStatus::SENDED->value;
        $this->application->save();
    }

    public function accept(): void
    {
        throw new HttpResponseException(response()->json([
            "message" => "A Solicitação Esta pendente de envio"
        ], 400));
    }

    public function reject(): void
    {
        throw new HttpResponseException(response()->json([
            "message" => "A Solicitação Esta pendente de envio"
        ], 400));
    }

}

