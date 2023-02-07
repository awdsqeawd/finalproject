<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Category;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CategoryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $categorytable = array(
        [
            'category_list' => 'Programming',
        ],
        [
            'category_list' => 'Technology',
        ],
        [
            'category_list' => 'Science',
        ],
        [
            'category_list' => 'Sports',
        ],
        [
            'category_list' => 'Random',
        ],
    );
        // ------ use for one seeding only
        foreach($categorytable as $key => $category){
            // $categorytable = Category::create($category);
            DB::table('category')->insert($category);
        }
    }
}
