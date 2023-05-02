module Meetup = struct
  type location = { lat : float; long : float } [@@deriving of_yaml, show]

  type t = {
    title : string;
    slug : string;
    url : string;
    textual_location : string;
    location : location;
  }
  [@@deriving show]
end
