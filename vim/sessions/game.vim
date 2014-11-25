" ~/dotfiles/vim/sessions/game.vim:
" Vim session script.
" Created by session.vim 2.7 on 19 octubre 2014 at 06:46:19.
" Open this file in Vim and run :source % to restore your session.

set guioptions=aegit
silent! set guifont=Inconsolata\ for\ Powerline\ Medium\ 13
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'Tomorrow-Night' | colorscheme Tomorrow-Night | endif
call setqflist([{'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make: Entering directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make[1]: Entering directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make[2]: Entering directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Scanning dependencies of target game'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make[2]: Leaving directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make[2]: Entering directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[  3%] [  6%] [  9%] [ 15%] [ 15%] [ 18%] [ 21%] [ 24%] [ 27%] Building CXX object CMakeFiles/game.dir/src/Animation/Animation.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/Graphics/Camera.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/main.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/TypeId/TypeId.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/Input/InputSystem.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/Components/RenderComponent.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/Graphics/World.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/Graphics/RenderSystem.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Building CXX object CMakeFiles/game.dir/src/Components/AnimationComponent.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 30%] Building CXX object CMakeFiles/game.dir/src/Input/PlayerManager.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 33%] Building CXX object CMakeFiles/game.dir/src/Core/Engine.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 36%] Building CXX object CMakeFiles/game.dir/src/Core/EntityManager.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 39%] Building CXX object CMakeFiles/game.dir/src/Event/EventHandler.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 42%] Building CXX object CMakeFiles/game.dir/src/Event/EventDispatcher.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 45%] Building CXX object CMakeFiles/game.dir/src/Serialize/Serializer.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 48%] Building CXX object CMakeFiles/game.dir/src/Physics/PhysicsSystem.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 51%] Building CXX object CMakeFiles/game.dir/src/Json/JsonReader.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 54%] Building CXX object CMakeFiles/game.dir/src/Json/JsonNode.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[ 57%] Building CXX object CMakeFiles/game.dir/src/Json/JsonWriter.cpp.o'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'Linking CXX executable ../bin/game'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make[2]: Leaving directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': '[100%] Built target game'}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make[1]: Leaving directory ''/home/boudra/dev/game/build'''}, {'lnum': 0, 'col': 0, 'valid': 0, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'Graphics/Shader.cpp', 'text': 'make: Leaving directory ''/home/boudra/dev/game/build'''}])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/dev/game/src
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/.gvimrc
badd +97 ~/.vimrc
badd +46 main.cpp
badd +198 Util/Memory.hpp
badd +34 \[Vundle]\ Installer
badd +88 Core/EntityManager.hpp
badd +2 Components/AnimationComponent.cpp
badd +53 ~/dev/game/src/Components/AnimationComponent.hpp
badd +28 TypeId/TypeId.hpp
badd +36 ~/dev/game/build/CMakeFiles/Makefile2
badd +30 ./Core/Logger.hpp
badd +1428 /usr/bin/../lib64/gcc/x86_64-unknown-linux-gnu/4.9.1/../../../../include/c++/4.9.1/type_traits
badd +93 Core/System.hpp
badd +37 ./Core/Component.hpp
badd +32 TypeId/Any.hpp
badd +1 ~/dev/game/src/TypeId/TypeId.cpp
badd +119 ./Json/JsonNode.hpp
badd +26 ~/dev/game/src/Json/JsonWriter.cpp
badd +148 ~/dev/game/src/Animation/Animation.cpp
badd +1 CMakeFiles/game.dir/src/main.cpp.o:/home/boudra/dev/game/src/Util/Memory.hpp
badd +21 ~/dev/game/src/Graphics/Camera.cpp
badd +121 ~/dev/game/src/Graphics/RenderSystem.cpp
badd +65 ~/dev/game/src/Graphics/World.cpp
badd +14 ~/dev/game/src/Components/RenderComponent.cpp
badd +1899 /usr/include/c++/4.9.1/functional
badd +28 ~/dev/game/src/Core/Engine.cpp
badd +32 Json/JsonReader.hpp
badd +26 Core/Entity.hpp
badd +133 Resource/Texture.hpp
badd +1 ~/dev/game/src/Resource/Texture.cpp
badd +25 Resource/ResourceManager.hpp
badd +134 Core/ObjectPool.hpp
badd +1 ~/dev/game/src/game.cpp
badd +54 /usr/bin/../lib64/gcc/x86_64-unknown-linux-gnu/4.9.1/../../../../include/c++/4.9.1/bits/predefined_ops.h
badd +1 Core/Logger.cpp
badd +24 ../CMakeLists.txt
badd +46 ~/dev/game/src/Components/PhysicsComponent.hpp
badd +11 ~/dev/game/src/Graphics/Camera.hpp
badd +76 ~/dev/game/src/Graphics/BufferObject.hpp
badd +81 ~/dev/game/src/Graphics/World.hpp
badd +25 ~/dev/game/src/Input/PlayerManager.cpp
badd +49 ~/dev/game/src/System/Window.hpp
badd +50 ~/dev/game/src/Core/Engine.hpp
badd +36 ~/dev/game/src/Resource/Font.hpp
badd +40 ~/dev/game/src/Json/JsonWriter.hpp
badd +1 Core/Component.cpp
badd +94 ~/dev/game/src/Graphics/BufferObject.cpp
badd +9 ~/dev/game/build/CMakeFiles/game.dir/flags.make
badd +151 Graphics/Shader.cpp
argglobal
silent! argdel *
edit TypeId/TypeId.hpp
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 106 + 106) / 212)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 212)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=20
setlocal fml=1
setlocal fdn=20
setlocal fen
17
silent! normal! zo
19
silent! normal! zo
36
silent! normal! zo
39
silent! normal! zo
49
silent! normal! zo
57
silent! normal! zo
57
silent! normal! zo
let s:l = 29 - ((26 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
29
normal! 0
wincmd w
argglobal
edit ~/dev/game/src/Core/Engine.cpp
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=20
setlocal fml=1
setlocal fdn=20
setlocal fen
21
silent! normal! zo
let s:l = 175 - ((37 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
175
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 106 + 106) / 212)
exe 'vert 2resize ' . ((&columns * 105 + 106) / 212)
tabnext 1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

2wincmd w
tabnext 1
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
