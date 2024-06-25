# flake.nix



{

	description = "test";



	inputs =

	{

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		old-python-nixpkgs.url = "github:nixos/nixpkgs/2030abed5863fc11eccac0735f27a0828376c84e";

	};



	outputs = { self, nixpkgs, ... }@inputs:

		let

		system = "x86_64-linux";

	pkgs = nixpkgs.legacyPackages.${system};

	in

	{

		devShells.x86_64-linux.default =

			pkgs.mkShell

			{

				nativeBuildInputs = with pkgs; [
					neovim
				];
				shellHook = ''


					TMP_DIR="$HOME/tmp"
					CONFIG_DIR="$HOME/.config"
					REPO="https://github.com/trevg22/configs.git"

					if [ ! -d "$CONFIG_DIR/blah" ]; then
						mkdir -p "$TMP_DIR"

						echo "Cloning into configs repo"
						git clone "$REPO" "$TMP_DIR/configs" --recurse-submodules
						mkdir -p "$CONFIG_DIR/blah"
						mv "$TMP_DIR"/configs/* "$CONFIG_DIR"
					else
						echo "Config already cloned."
					fi


					'';

			};

		};

	}


