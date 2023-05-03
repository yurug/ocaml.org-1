open Ocamlorg.Type

type metadata = {
  name : string;
  description : string;
  url : string;
  logo : string option;
  continent : string;
  courses : Academic_institution.course list;
  location : Location.t option;
}
[@@deriving
  of_yaml,
    stable_record ~version:Academic_institution.t
      ~add:[ body_md; body_html; slug ]]

let of_metadata m =
  metadata_to_Academic_institution_t m ~slug:(Utils.slugify m.name)

let decode (_, (head, body_md)) =
  let metadata = metadata_of_yaml head in
  let body_html = Omd.of_string body_md |> Omd.to_html in
  Result.map (of_metadata ~body_md ~body_html) metadata

let all () = Utils.map_files decode "academic_institutions"

let template () =
  Format.asprintf {|
open Ocamlorg
let all = %a
|}
    (Fmt.brackets (Fmt.list Academic_institution.pp ~sep:Fmt.semi))
    (all ())
