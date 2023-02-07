<?php

/** @var \Laravel\Lumen\Routing\Router $router */

// $router->get('/note')

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/




$router->get('/', function () use ($router) {
    echo "<center> Welcome </center>";
});

$router->get('/version', function () use ($router) {
    return $router->app->version();
});

Route::group([

    'prefix' => 'api'

], function ($router) {
    Route::post('login', 'AuthController@login');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::post('user-profile', 'AuthController@me');
    Route::post('register', 'AuthController@register');

});

Route::group([

    'prefix' => 'crud'
], function ($router) {
    Route::get('index', 'NoteController@index');
    Route::get('show/{id}', 'NoteController@show');
    Route::post('create', 'NoteController@create');
    Route::put('update/{id}', 'NoteController@update');
    Route::delete('delete/{id}', 'NoteController@delete');
});