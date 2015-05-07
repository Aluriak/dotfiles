
copy:
	cp ~/.vimrc ./
	cp ~/.vimrc.bepo ./

df:
	git diff 
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
