<?php

namespace App\Enums;

enum ApplicationLicenseType: string
{
    case COMMERCIAL = "CMT";
    case INDUSTRIAL = "IND";
    case RESIDENTIAL = "RST";
}
