module Asset = Asset
module Media = Media

let of_url_path = File.of_url_path

(* given the path of a file from `assets.ml`: 1. looks up the file's digest in
   and 2. returns the corresponding digest URL for use in templates *)
let url filepath =
  let digest = Asset.hash filepath in
  if digest = None then
    raise
      (Invalid_argument
         (Fmt.str
            "ERROR: '%s' is rendered via asset_digest_url, but it is not an \
             asset!"
            filepath));
  File.to_url_path filepath (Option.map Dream.to_base64url digest)
