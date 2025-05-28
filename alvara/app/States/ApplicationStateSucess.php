<?php

use App\Models\Application;

class ApplicationStateSuccess implements IApplicationState {
    protected Application $application;

    public function __construct(Application $application) {
        $this->application = $application;
    }

    public function send(): void
    {
        throw new Exception("A Solicitação foi Aceita");

    }

    public function accept(): void
    {

        throw new Exception("A Solicitação foi Aceita");
    }

    public function reject(): void
    {

        throw new Exception("A Solicitação já foi Aceita");
    }

}

