open OUnit2
open ListLabels
open TestCommon
open Util

let tear_down () text_ctxt = ()

let test_serialize_not_leader text_ctxt =
  assert_equal ((2, 15), "NotLeader 2 15")
    (VarDSerialization.serialize (VarDRaft.NotLeader (2, 15)))

let test_serialize_client_response test_ctxt =
  let o = VarDRaft.Response (char_list_of_string "awesome", None, None) in
  assert_equal ((3, 34), "Response 3 34 awesome - -")
    (VarDSerialization.serialize (VarDRaft.ClientResponse (3, 34, (Obj.magic o))))
  
let test_list =
  [
    "serialize NotLeader", test_serialize_not_leader;
    "serialize ClientResponse", test_serialize_client_response
  ]

let tests =
  "VarDSerialization" >:::
    (map test_list ~f:(fun (name, test_fn) ->
      name >:: (fun test_ctxt ->
	bracket ignore tear_down test_ctxt;
	test_fn test_ctxt)
     ))