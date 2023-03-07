function font-patcher --description 'Patch fonts'
    mkdir ./patched-fonts
    mkdir ./fonts-to-patch

    for i in ./fonts-to-patch/*.ttf
        # fontforge -script font-patcher --fontawesome --fontawesomeextension --octicons --codicons --powerline \
        # --powersymbols --powerlineextra --material --weather --fontlogos --pomicons \
        fontforge -script font-patcher --fontawesome --fontawesomeextension --powerline \
        --powersymbols --powerlineextra \
        -out ./patched-fonts $i;
    end

    for i in ./patched-fonts/*.ttf
        echo $i | tr '[:upper:]' '[:lower:]' | sed 's/\ /-/g' | xargs cp $i -- && rm $i
    end
end
