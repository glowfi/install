# Pywal
# pip install pywal colorz
if type -q wal
    if test -e ~/.cache/wal/wal
        rg "Image" ~/.config/plasma-org.kde.plasma.desktop-appletsrc | tail -1 | awk -F':' '{print $2}' |awk 'sub(/^.{3}/,"")'| awk -F'/' '{print $4}'| read -t wloc
        awk -F'/' '{print $5}' ~/.cache/wal/wal |read -t wloc1
        if test "$wloc" = "$wloc1"
            dash -c "(cat ~/.cache/wal/sequences &);clear"
        else
            wal -e -n -q --backend colorz -i ~/wall/$wloc
        end
    else
        rg "Image" ~/.config/plasma-org.kde.plasma.desktop-appletsrc | tail -1 | awk -F':' '{print $2}' |awk 'sub(/^.{3}/,"")'| awk -F'/' '{print $4}'| read -t wloc
        wal -e -n -q --backend colorz -i ~/wall/$wloc
    end
end
