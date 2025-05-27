<?php

namespace App\Models;

use ApplicationStateOpen;
use ApplicationStateRejected;
use ApplicationStateSucess;
use ApplicationStateSended;
use IApplicationState;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Enums\ApplicationStatus;
use Illuminate\Database\Eloquent\Relations\HasMany;
use PHPUnit\Exception;

class Application extends Model
{
    use HasFactory;

    protected $fillable = ["status","title"];

    protected $cast = [
        "status" => ApplicationStatus::class,
    ];
    /**
     * @return HasMany<Attachment,Application>
     */
    public function attachments(): HasMany {
        return $this->hasMany(Attachment::class);
    }

    public function getStatusController(): IApplicationState {
        switch ($this->status) {
            case ApplicationStatus::SUCCESS:
                return new ApplicationStateSucess($this);
            case ApplicationStatus::OPEN:
                return new ApplicationStateOpen($this);
            case ApplicationStatus::SENDED:
                return new ApplicationStateSended($this);
            case ApplicationStatus::REJECTED:
                return new ApplicationStateRejected($this);

            default:
                throw new Exception("Status não encontrado");
                break;
        }
    }
}
