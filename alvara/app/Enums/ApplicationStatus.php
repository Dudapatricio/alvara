<?php

namespace App\Enums;

enum ApplicationStatus:string
{
    case IN_PROGRESS = "IPG";
    case SUCCESS = "SUS";
    case REJECTED = "RGC";
}
