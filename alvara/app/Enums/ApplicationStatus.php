<?php

namespace App\Enums;

enum ApplicationStatus:string
{
    case OPEN = "OPN";
    case SENDED = "SED";
    case SUCCESS = "SUS";
    case REJECTED = "RGC";
}
