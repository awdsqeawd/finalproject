<?php 

    namespace App\Http\Controllers;

    use Illuminate\Http\Request;
    use Illuminate\Support\Facades\Auth;
    use App\Models\Note;

    class NoteController extends Controller {

        public function __construct()
    {
        $this->middleware('auth:crud', ['except' => ['index', 'show', 'create', 'update', 'delete']]);
    }
    /**
     * Get a JWT via given credentials.
     *
     * @param  Request  $request
     * @return Response
     */

        //return all notes
        public function index(){

            $note = Note::all();
            return response()->json($note);
        }

        //return notes based on ID
        public function show($id){

            $note = Note::find($id);
            return response()->json($note);
        }

        //create notes
        public function create(Request $request){

            $note = new Note();

            $note->user_id = $request->user_id;
            $note->privacy = $request->privacy;
            $note->description = $request->description;
            $note->title = $request->title;
            $note->category = $request->category;

            $note->save();

            return response()->json("Note Successfully Created!");
        }


        //update notes
        public function update(Request $request, $id){

            $note = Note::find($id);

            $note->privacy = $request->privacy;
            $note->description = $request->description;
            $note->title = $request->title;
            $note->category = $request->category;

            $note->save();

            return response()->json($id);

        }


        //delete notes
        public function delete($id){

            $note = Note::find($id);
            $note->delete();
            
            return response()->json('Note Successfully Deleted!');
            
        }

    }