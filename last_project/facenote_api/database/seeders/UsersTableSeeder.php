<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;


class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users = array([
            'name' => 'Md.Meherul Islam', 
            'email' => 'meherul@gmail.com',
            'password' => Hash::make('12345678')
        ],
        [
            'name' => 'Abdol Jabol', 
            'email' => 'jab@gmail.com',
            'password' => Hash::make('12345678')
        ],
        [
            'name' => 'Bol Abdol',
            'email' => 'bol@gmail.com',
            'password' => Hash::make('12345678')
        ],
    );
        // ------ use for one seeding only
        // foreach($users as $key => $user){
        //     $users = User::create($user);
        // }

        // use for all and new users
        foreach($users as $key => $user){
            $check = User::where('email', '=', $user['email'])->first();
            if ($check === null) {
              $user = User::create($user);
            }
        }
    }
}