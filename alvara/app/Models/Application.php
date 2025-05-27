<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Enums\ApplicationStatus;

class Application extends Model
{
    use HasFactory;

    protected $fillable = ["status","title"];

    protected $cast = [
        "status" => ApplicationStatus::class,
    ];

    public function attachments() {
        return $this->hasMany(Attachment::class);
    }
}
