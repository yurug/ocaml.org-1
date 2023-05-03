module Location = struct
  type t = { lat : float; long : float } [@@deriving of_yaml, show]
end

module Academic_institution = struct
  type course = {
    name : string;
    acronym : string option;
    online_resource : string option;
  }
  [@@deriving of_yaml, show]

  type t = {
    name : string;
    slug : string;
    description : string;
    url : string;
    logo : string option;
    continent : string;
    courses : course list;
    location : Location.t option;
    body_md : string;
    body_html : string;
  }
  [@@deriving show]
end

module Meetup = struct
  type t = {
    title : string;
    slug : string;
    url : string;
    textual_location : string;
    location : Location.t;
  }
  [@@deriving show]
end
