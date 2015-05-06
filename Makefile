
copy:
	cp ~/.vimrc ./
	cp ~/.vimrc.bepo ./

add:
	git add .vimrc

addbepo:
	git add .vimrc.bepo

addall: add addbepo

commit: copy addall
	git commit
