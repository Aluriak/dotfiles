
copy:
	cp ~/.vimrc ./
	cp ~/.vimrc.bepo ./

u: update
update:
	cp .vimrc ~/.vimrc

dfv:
	git diff .vimrc

ap:
	git add -p .vimrc

add:
	git add .vimrc

addbepo:
	git add .vimrc.bepo

addall: add addbepo

commit: copy addall
	git commit

df:
	vimdiff ~/.vimrc ./.vimrc
