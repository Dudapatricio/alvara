<?php

namespace App\Http\Controllers;

use App\Models\Attachment;
use Illuminate\Http\Request;

class AttachmentController extends Controller
{
    public function upload(Request $request) {
        $request->validate([
            "application_id" => "required|exists:application_id",
            "file" => "required|file|mimes:jpeg,jpg,png,pdf|max:5120", // 5MB
            "filename" => "required|filename"
        ]);

        $path = $request->file("file")->store("attachments", "public");

        Attachment::create([
            "application_id"=> $request->application_id,
            "path"=> $path,
            "filename"=> $request->filename,
        ]);

        return response()->json([
            "message"=> "Arquivo enviado com successo"
        ]);
    }
}
