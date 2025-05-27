<?php

use App\Models\Application;

class ApplicationStateInProgress implements IApplicationState {

    protected Application $application;

    public function __construct(Application $application) {
        $this->application = $application;
    }
    public function send(): void
    {
        throw new Exception("A Solicitação ja esta em andamento");
    }

    public function accept(): void
    {
    }

    public function reject(): void
    {
    }

}
