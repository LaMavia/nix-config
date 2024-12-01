#!/usr/bin/env bash

DLROOT="https://launcher.crystal-launcher.net/linux"
LAUNCHER_URL="$DLROOT/launcher.tar.xz"
LAUNCHER_ICON_URL="$DLROOT/icon.png"

INSTALLDIR=$HOME/Crystal-Launcher

function downloadFile {
	if [[ -x "$(command -v wget)" ]]; then
		wget "$1" -O "$2";
		if [[ $? -ne 0 ]]; then 
			echo "Downloading launcher failed!!!"; 
			exit 1; 
		fi;
	elif [[ -x "$(command -v curl)" ]]; then
		curl -L -o "$2" "$1";
		if [[ $? -ne 0 ]]; then 
			echo "Downloading launcher failed!!!"; 
			exit 1; 
		fi;
	else
    		echo "Unable to find wget and curl in system... Pleas install one of it..."
		exit 1; 
	fi
}

function createActivator {
    ACTIVATOR="[Desktop Entry]\n
            Name=Crystal Launcher\n
            GenericName=CrystalLauncher\n
            Comment=A Minecraft modpack launcher\n
            Exec=$INSTALLDIR/pybootstrap/run\n
            Icon=$INSTALLDIR/pybootstrap/icon.png\n
            Terminal=false\n
            Type=Application\n
            Categories=Game;\n"

    mkdir -p "$HOME/.local/share/applications"
	echo -e $ACTIVATOR > "$HOME/.local/share/applications/CrystalLauncher.desktop"

    if [[ -f "`which update-desktop-database `" ]]; then
		update-desktop-database "$HOME/.local/share/applications";
	fi;
}

function detectLauncherFiles {
    if [[ -f "$HOME/.crystalinst" ]]; then
        echo "Using .crystalinst file..."
        INSTALLDIR=$(<"$HOME/.crystalinst")
    else
        INSTALLDIR="$HOME/Crystal-Launcher"
    fi
}

function downloadBootstrap {
    mkdir -p "$INSTALLDIR/pybootstrap"
    (
        cd "$INSTALLDIR/pybootstrap"

        echo "Downloading core launcher files..."
        downloadFile "$LAUNCHER_URL"             "launcher.tar.xz"
        downloadFile "$LAUNCHER_URL.sha256"      "launcher.tar.xz.sha256"
        downloadFile "$LAUNCHER_ICON_URL"        "icon.png"
        downloadFile "$LAUNCHER_ICON_URL.sha256" "icon.png.sha256"

        sha256sum --check "launcher.tar.xz.sha256"
        if [[ $? -ne 0 ]]; then
            echo "Invalid checksum for file launcher.tar.xz!!!"
            exit 1
        fi

        sha256sum --check "icon.png.sha256"
        if [[ $? -ne 0 ]]; then
            echo "Invalid checksum for file icon.png!!!"
            rm launcher.tar.xz launcher.tar.xz.sha256 icon.png icon.png.sha256
            exit 1
        fi

        tar -xvf launcher.tar.xz
        if [[ $? -ne 0 ]]; then
            echo "Failed to extract launcher files!!!"
            rm launcher.tar.xz launcher.tar.xz.sha256 icon.png icon.png.sha256
            exit 1
        fi

        rm launcher.tar.xz launcher.tar.xz.sha256 icon.png.sha256

        echo -e '#!/usr/bin/env bash\n
        \n
        # manjaro fix\n
        xrdb -load /dev/null\n
        xrdb -query\n
        \n
        cd `dirname "$0"` && cd .. && ./pybootstrap/launcher\n' > run

        chmod +x run 
        chmod +x launcher
    )
}

detectLauncherFiles
echo "Installation path: $INSTALLDIR"
downloadBootstrap
createActivator
clear
echo -e "\n\nDone! Now you can start the launcher from the applications menu or by using the command:\n\n\t $INSTALLDIR/pybootstrap/run\n\n"
