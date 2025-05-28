<?php

use App\Enums\ApplicationStatus;
use App\Enums\ApplicationLicenseType;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('applications', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignId("company_id")->constrained()->onDelete("cascade");
            $table->string("status")->default(ApplicationStatus::OPEN);
            $table->string("title");
            $table->enum("type", [
                ApplicationLicenseType::COMMERCIAL->value,
                ApplicationLicenseType::INDUSTRIAL->value,
                ApplicationLicenseType::RESIDENTIAL->value,
            ]);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('applications');
    }
};
