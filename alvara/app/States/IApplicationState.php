<?php

namespace App\States;

interface IApplicationState {
    public function send():void;
    public function accept():void;
    public function reject():void;
}
