<?php

use App\Models\Application;

interface IApplicationState {
    public function send():void;
    public function accept():void;
    public function reject():void;
    public function __construct(Application $application);
}
