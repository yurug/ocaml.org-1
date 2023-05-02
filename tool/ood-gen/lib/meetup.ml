open Ocamlorg.Type.Meetup

type metadata = {
  title : string;
  url : string;
  textual_location : string;
  location : location;
}
[@@deriving of_yaml, stable_record ~version:t ~add:[ slug ]]

let of_metadata m = metadata_to_t m ~slug:(Utils.slugify m.title)
let decode s = Result.map of_metadata (metadata_of_yaml s)
let all () = Utils.yaml_sequence_file decode "meetups.yml"

let template () =
  Format.asprintf {|
open Ocamlorg
let all = %a
|}
    (Fmt.brackets (Fmt.list pp ~sep:Fmt.semi))
    (all ())
