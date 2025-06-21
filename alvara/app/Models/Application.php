<?php

namespace App\Models;

use App\States\ApplicationStateOpen;
use App\States\ApplicationStateRejected;
use App\States\ApplicationStateSended;
use App\States\ApplicationStateSuccess;
use App\States\IApplicationState;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Enums\ApplicationStatus;
use App\Enums\ApplicationLicenseType;
use PHPUnit\Exception;

class Application extends Model
{
    use HasFactory;

    protected $fillable = [
        "id",
        "status",
        "title",
        "type",
        "company_id",
    ];

    protected $cast = [
        "status" => ApplicationStatus::class,
        "type" => ApplicationLicenseType::class,
    ];
    public function attachments()
    {
        return $this->hasMany(Attachment::class);
    }

    public function getStatusController(): IApplicationState
    {
        switch ($this->status) {
            case ApplicationStatus::SUCCESS->value:
                return new ApplicationStateSuccess($this);
            case ApplicationStatus::OPEN->value:
                return new ApplicationStateOpen($this);
            case ApplicationStatus::SENDED->value:
                return new ApplicationStateSended($this);
            case ApplicationStatus::REJECTED->value:
                return new ApplicationStateRejected($this);

            default:
                throw new Exception("Status não encontrado");
                break;
        }
    }
}
