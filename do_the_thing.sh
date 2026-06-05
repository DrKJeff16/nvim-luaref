#!/usr/bin/env bash

PREFIX="https://www.lua.org/manual/5.1"

mkdir -p doc translations html org

if ! [[ -f html/en.html ]]; then
    wget ${PREFIX}/manual.html -O html/en.html
    for LANG in pt es de; do
        wget "${PREFIX}/${LANG}/manual.html" -O html/"${LANG}.html"
    done
    for LANG in en pt es de; do
        nvim -es -u NONE html/${LANG}.html +"set fileencoding=utf8|wq"
    done
fi

for LANG in en pt es de; do
    echo Converting html/${LANG}.html to org/${LANG}.org
    pandoc html/${LANG}.html -o org/${LANG}.org

    echo Making edits and writing translations/lua_reference.${LANG}x
    cat edit_org_to_help.vim | nvim -es -u NONE org/${LANG}.org

    echo
done

echo -e "\nvim: set tw=78 ts=4 sw=4 sts=4 et ai si sta ft=help norl:" >> translations/lua_reference.enx

echo "==============================================================================" >| doc/lua_reference.txt
echo -e "*lua_reference.txt*                                     Lua 5.1 reference manual\n" >> doc/lua_reference.txt

cat translations/lua_reference.enx >> doc/lua_reference.txt
rm -rf html org translations/lua_reference.enx

nvim --headless --clean -c "helptags doc/" -c "qa!"
