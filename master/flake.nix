{
  description = ''Flippy is a simple 2d image and drawing library.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-flippy-master.flake = false;
  inputs.src-flippy-master.ref   = "refs/heads/master";
  inputs.src-flippy-master.owner = "treeform";
  inputs.src-flippy-master.repo  = "flippy";
  inputs.src-flippy-master.type  = "github";
  
  inputs."vmath".owner = "nim-nix-pkgs";
  inputs."vmath".ref   = "master";
  inputs."vmath".repo  = "vmath";
  inputs."vmath".dir   = "1_2_0";
  inputs."vmath".type  = "github";
  inputs."vmath".inputs.nixpkgs.follows = "nixpkgs";
  inputs."vmath".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."chroma".owner = "nim-nix-pkgs";
  inputs."chroma".ref   = "master";
  inputs."chroma".repo  = "chroma";
  inputs."chroma".dir   = "0_2_7";
  inputs."chroma".type  = "github";
  inputs."chroma".inputs.nixpkgs.follows = "nixpkgs";
  inputs."chroma".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."nimpng".owner = "nim-nix-pkgs";
  inputs."nimpng".ref   = "master";
  inputs."nimpng".repo  = "nimpng";
  inputs."nimpng".dir   = "v0_3_2";
  inputs."nimpng".type  = "github";
  inputs."nimpng".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimpng".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."supersnappy".owner = "nim-nix-pkgs";
  inputs."supersnappy".ref   = "master";
  inputs."supersnappy".repo  = "supersnappy";
  inputs."supersnappy".dir   = "2_1_3";
  inputs."supersnappy".type  = "github";
  inputs."supersnappy".inputs.nixpkgs.follows = "nixpkgs";
  inputs."supersnappy".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."bumpy".owner = "nim-nix-pkgs";
  inputs."bumpy".ref   = "master";
  inputs."bumpy".repo  = "bumpy";
  inputs."bumpy".dir   = "1_1_1";
  inputs."bumpy".type  = "github";
  inputs."bumpy".inputs.nixpkgs.follows = "nixpkgs";
  inputs."bumpy".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-flippy-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-flippy-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}