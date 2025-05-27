<?php

'api' => [
    /*\Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful::class, // opcional se usar SPA*/
    'throttle:api',
    \Illuminate\Routing\Middleware\SubstituteBindings::class,
],
