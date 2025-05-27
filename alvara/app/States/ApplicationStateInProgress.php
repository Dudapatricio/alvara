<?php
class ApplicationStateInProgress implements IApplicationState {
    public function send(): void
    {
        throw new Exception("Error Processing Request", 1);
    }

    public function accept(): void
    {
    }

    public function reject(): void
    {
    }

}
