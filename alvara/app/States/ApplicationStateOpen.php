<?php

use App\Models\Application;

class ApplicationStateOpen implements IApplicationState {

    protected Application $application;

    public function __construct(Application $application) {
        $this->application = $application;
    }
    public function send(): void
    {
        throw new Exception("A Solicitação foi rejeitada");

    }

    public function accept(): void
    {

        throw new Exception("A Solicitação foi rejeitada");
    }

    public function reject(): void
    {

        throw new Exception("A Solicitação já foi rejeitada");
    }

}

