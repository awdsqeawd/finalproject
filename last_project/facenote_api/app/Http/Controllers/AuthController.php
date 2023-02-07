<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use  App\Models\User;
use App\Models\Note;

class AuthController extends Controller
{


    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'refresh', 'logout', 'register']]);
    }
    /**
     * Get a JWT via given credentials.
     *
     * @param  Request  $request
     * @return Response
     */
    public function login(Request $request)
    {

        $this->validate($request, [
            'email' => 'required|string',
            'password' => 'required|string',
        ]);

        $credentials = $request->only(['email', 'password']);

        if (! $token = Auth::attempt($credentials)) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

     /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'user' => auth()->user(),
            'expires_in' => auth()->factory()->getTTL() * 60 * 24
        ]);
    }

    public function register(Request $request){

        // dd($request);
        //validate data
        $this->validate($request, [
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required',
        ]);
        //end validation

        // register user

        try {
            $user = new User;
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $password = $request->input('password');
            //this will create hash string
            $user->password = app('hash')->make($password);

            //save user
            if($user->save()){
                $code = 200;
                $output = [
                    'user' => $user,
                    'code' => 200,
                    'message' => 'User created successfully.',
                ];
            } else {
                $code = 500;
                $output = [
                    'code' => $code,
                    'message' => 'An error occured while creating user.',
                ];
            }

        } catch (Exception $e) {
            // dd($th->getMessage());
            $code = $code;
            $output = [
                'code' => 500,
                'message' => 'An error occured while creating user.',
            ];
        }
        //end register user

        return response()->json($output, $code);

    }
    
}